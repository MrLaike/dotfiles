return {
    "mbrea-c/wal-colors.nvim",
    config = function ()
        vim.cmd([[colorscheme mbc]])
    end,
    init = function ()
        local config = function (colors)
            local set = {
                WinSeparator = { fg = colors.color5, bg = colors.background },
                -- ColorColumn = { fg = colors.foreground,  bg = colors.color5 },
                -- SignColumn = { bg = colors.color2 },
            }
            --set["@constant"] = { italic = false, fg = colors.color6:darkened(), bold = true }
            --set["@keyword"] = { italic = false, fg = colors.blue, bold = true }
            --set["@comment"] = { italic = true, fg = colors.color8, bold = true }
            
            return set;
        end

        require("wal-colors").setup(config)

    end
}
