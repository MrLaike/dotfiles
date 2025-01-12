return {
    'norcalli/nvim-colorizer.lua',
    config = function ()
        require('colorizer').setup({
            'css';
            'javascript';
            'html';
        }, { mode = 'foreground', names = false, rgb_fn = true })
    end
}
