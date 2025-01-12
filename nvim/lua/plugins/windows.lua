return {
    "anuvyklack/windows.nvim",
    dependencies = {
        "anuvyklack/middleclass",
        "anuvyklack/animation.nvim"
    },
    init = function()
        require('windows').setup()
    end
}
