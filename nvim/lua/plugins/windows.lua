return {
    "anuvyklack/windows.nvim",
    dependencies = {
        "anuvyklack/middleclass",
        "anuvyklack/animation.nvim"
    },
    init = function()
        require('windows').setup()

        vim.o.winwidth = 40
        vim.o.winminwidth = 40
        vim.o.equalalways = false

        -- vim.api.nvim_create_autocmd('WinEnter', {
        --     group = augroup,
        --     callback = function(_)
        --         vim.api.nvim_command(":WindowsMaximizeHorizontally")
        --     end,
        --     desc = 'Autoresize windows when focus',
        -- })

    end
}
