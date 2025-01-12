return {
    "luukvbaal/statuscol.nvim",
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
        local is_git = function()
            local is_git = vim.fn.isdirectory(vim.fn.getcwd() .. "/" .. ".git");
            if is_git ~= 1 then is_git = vim.fn.filereadable(vim.fn.getcwd() .. "/" .. ".git") end

            return is_git
        end;
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            setopt = true,
            thousands = false,
            relculright = true,
            ft_ignore = nil,
            bt_ignore = nil,
            segments = {
                { sign = { namespace = { ".*" }, maxwidth = 1, colwidth = 1, auto = true }},
                { sign = { namespace = { "diagnostic" }, maxwidth = 0, colwidth = 0, auto = false } },
                {
                    text = { builtin.lnumfunc, function (args)
                        return ((is_git() ~= 0) and "" or "│")
                    end },
                    condition = { builtin.not_empty },
                    sign = {
                        maxwidth = 1,
                        colwidth = 1,
                    }
                },
                {
                    sign = {
                        namespace = { "gitsigns" },
                        maxwidth = 1,
                        colwidth = 1,
                        auto = false,
                        fillchar = "│",
                        fillcharhl = "StatusColumnSeparator",
                    },
                    condition = { function (args)
                        return is_git() ~= 0
                    end },
                    click = "v:lua.ScSa",
                },
            },
        })
    end,
}
