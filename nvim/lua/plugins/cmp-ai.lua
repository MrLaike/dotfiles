return {
    'tzachar/cmp-ai',
    dependencies = 'nvim-lua/plenary.nvim',
    opt = function ()
        return {
            max_lines = 100,
            provider = 'Ollama',
            provider_options = {
                model = 'deepseek-coder-v2',
                prompt = function(lines_before, lines_after)
                  return lines_before
                end,
                suffix = function(lines_after)
                  return lines_after
                end,
            },
            notify = true,
            notify_callback = function(msg)
                vim.notify(msg)
            end,
            run_on_every_keystroke = true,
            ignored_file_types = {
            },
        }
    end
}
