local M = {}

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

-- Convert testMethodName to "Test Method Name"
function M.parse_test_name(method_name)
    -- Remove 'test' prefix
    local without_test = method_name:gsub('^test', '')

    -- Handle snake_case
    local spaces = without_test:gsub('_', ' ')

    -- Handle camelCase - insert space before capitals
    local with_spaces = spaces:gsub('(%l)(%u)', '%1 %2')

    -- Title case: capitalize first letter of each word
    local title_cased = 'Test ' .. with_spaces:gsub('(%a)([%w]*)', function(first, rest)
        return first:upper() .. rest:lower()
    end)

    return title_cased
end

-- Parse PHPUnit --list-tests output to extract methods and their data provider cases
function M.parse_phpunit_output(output)
    local tests = {}
    local test_map = {}

    for _, line in ipairs(output) do
        local method_name, case_name

        -- Try named data provider: ::testMethod"case name"
        method_name, case_name = line:match('::([%w_]+)"([^"]+)"')

        if not method_name then
            -- Try numeric data provider: ::testMethod#N
            local method_num, case_index = line:match('::([%w_]+)#(%d+)')
            if method_num then
                method_name = method_num
                case_name = tonumber(case_index)
            else
                -- Simple test without data provider
                method_name = line:match('::([%w_]+)%s*$')
            end
        end

        if method_name and method_name:match('^test') then
            if not test_map[method_name] then
                test_map[method_name] = { method = method_name, cases = {} }
                table.insert(tests, test_map[method_name])
            end
            if case_name ~= nil then
                table.insert(test_map[method_name].cases, case_name)
            end
        end
    end

    return tests
end

-- Find data provider method name by searching backwards from test method
function M.find_data_provider_method(lines, test_method_line)
    local start_line = math.max(1, test_method_line - 20)

    for i = test_method_line - 1, start_line, -1 do
        local line = lines[i]

        -- Check for attribute: #[DataProvider('methodName')] or #[DataProvider("methodName")]
        local attr_match = line:match("#%[DataProvider%(['\"]([%w_]+)['\"]%)%]")
        if attr_match then
            return attr_match
        end

        -- Check for annotation: @dataProvider methodName
        local annot_match = line:match("@dataProvider%s+([%w_]+)")
        if annot_match then
            return annot_match
        end

        -- Stop if we hit another function or class definition
        if line:match("^%s*public%s+function%s") or line:match("^%s*private%s+function%s")
           or line:match("^%s*protected%s+function%s") or line:match("^%s*class%s") then
            break
        end
    end

    return nil
end

-- Find the line number of a method definition
function M.find_method_line(lines, method_name)
    local pattern = 'function%s+' .. method_name .. '%s*%('

    for line_num, line_content in ipairs(lines) do
        if line_content:match(pattern) then
            return line_num
        end
    end

    return nil
end

-- Find the line number of a specific yield/case in a data provider method
function M.find_yield_line(lines, provider_method, case_name)
    -- First find the data provider method
    local provider_start = M.find_method_line(lines, provider_method)
    if not provider_start then
        return nil
    end

    -- Find method end by tracking braces
    local provider_end = nil
    local brace_count = 0
    local in_method = false

    for i = provider_start, #lines do
        local line = lines[i]
        for _ in line:gmatch('{') do
            brace_count = brace_count + 1
            in_method = true
        end
        for _ in line:gmatch('}') do
            brace_count = brace_count - 1
        end
        if in_method and brace_count == 0 then
            provider_end = i
            break
        end
    end

    provider_end = provider_end or #lines

    if type(case_name) == 'number' then
        -- Numeric index: count yield statements or array entries
        local yield_count = 0
        for i = provider_start, provider_end do
            local line = lines[i]
            -- Match yield statements or array entries with =>
            if line:match("yield%s") or line:match("^%s*%[.*=>") or line:match("^%s*['\"].*['\"]%s*=>") then
                if yield_count == case_name then
                    return i
                end
                yield_count = yield_count + 1
            end
        end
    else
        -- Named case: find the specific yield or array key
        local escaped_name = case_name:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
        for i = provider_start, provider_end do
            local line = lines[i]
            -- Match yield 'case name' => or 'case name' => (in array)
            if line:match("['\"]" .. escaped_name .. "['\"]%s*=>") then
                return i
            end
        end
    end

    -- Fallback to provider method start
    return provider_start
end

-- Build picker entries with test methods and their data provider cases
function M.build_picker_entries(tests, lines)
    local entries = {}

    for _, test in ipairs(tests) do
        local method_line = M.find_method_line(lines, test.method)

        -- Add the test method entry
        table.insert(entries, {
            type = 'method',
            method = test.method,
            display = M.parse_test_name(test.method),
            ordinal = M.parse_test_name(test.method),
            line = method_line,
        })

        -- Add data provider cases if any
        if #test.cases > 0 and method_line then
            local provider_method = M.find_data_provider_method(lines, method_line)

            for _, case_name in ipairs(test.cases) do
                local case_line = nil
                if provider_method then
                    case_line = M.find_yield_line(lines, provider_method, case_name)
                end

                local display_name
                if type(case_name) == 'number' then
                    display_name = string.format('    #%d', case_name)
                else
                    display_name = string.format('    %s', case_name)
                end

                table.insert(entries, {
                    type = 'case',
                    method = test.method,
                    case_name = case_name,
                    display = display_name,
                    ordinal = M.parse_test_name(test.method) .. ' ' .. tostring(case_name),
                    line = case_line or method_line,
                })
            end
        end
    end

    return entries
end

-- Get test methods with their data provider cases from phpunit
function M.get_test_methods(filepath, callback)
    local project_root = vim.fn.getcwd()
    local phpunit_path = project_root .. '/vendor/bin/phpunit'

    if vim.fn.filereadable(phpunit_path) == 0 then
        vim.notify('vendor/bin/phpunit not found', vim.log.levels.ERROR)
        callback({})
        return
    end

    local Job = require('plenary.job')

    Job:new({
        command = phpunit_path,
        args = { '--list-tests', filepath },
        cwd = project_root,
        on_exit = function(j, return_val)
            vim.schedule(function()
                if return_val ~= 0 then
                    vim.notify('PHPUnit command failed', vim.log.levels.WARN)
                    callback({})
                    return
                end

                local output = j:result()
                local tests = M.parse_phpunit_output(output)

                if #tests == 0 then
                    vim.notify('No test methods found in file', vim.log.levels.WARN)
                end

                callback(tests)
            end)
        end,
    }):start()
end

-- Main picker function
function M.pick_test_methods()
    local filepath = vim.api.nvim_buf_get_name(0)

    if not filepath:match('Test%.php$') then
        vim.notify('Current file is not a PHP test file', vim.log.levels.WARN)
        return
    end

    -- Read buffer lines once
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    M.get_test_methods(filepath, function(tests)
        if #tests == 0 then
            return
        end

        local entries = M.build_picker_entries(tests, lines)

        pickers.new({}, {
            prompt_title = 'PHPUnit Tests',
            finder = finders.new_table({
                results = entries,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry.display,
                        ordinal = entry.ordinal,
                        filename = filepath,
                        lnum = entry.line,
                    }
                end,
            }),
            sorter = conf.generic_sorter({}),
            previewer = conf.grep_previewer({}),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)

                    if not selection then
                        return
                    end

                    local line_num = selection.value.line
                    if line_num then
                        vim.api.nvim_win_set_cursor(0, { line_num, 0 })
                        vim.cmd('normal! zz')
                    else
                        vim.notify('Could not find location', vim.log.levels.WARN)
                    end
                end)

                return true
            end,
        }):find()
    end)
end

return M
