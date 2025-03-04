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
            relculright = false,
            ft_ignore = nil,
            bt_ignore = nil,
            segments = {
                { sign = { name = { ".*" }, namespace = { ".*" }, maxwidth = 1, colwidth = 2, auto = false }},
                {
                    text = {
                        function(args, segment)
                            local reverse = string.reverse
                            local thousand_separator = " "
                            if not args.rnu and not args.nu then return "" end
                            if args.virtnum ~= 0 then return "%=" end

                            local lnum = args.rnu and (args.relnum > 0 and args.relnum
                            or (args.nu and args.lnum or 0)) or args.lnum

                            if lnum > 999 then
                                lnum = reverse(lnum):gsub("%d%d%d", "%1"..thousand_separator):reverse():gsub("^%"..thousand_separator, "")
                            end

                            return tostring(lnum).."%="
                        end,
                        function (args)
                            return ((is_git() ~= 0) and "" or "│")
                        end
                    },
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
