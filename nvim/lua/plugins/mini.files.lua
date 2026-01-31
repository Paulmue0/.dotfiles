return {
    -- Mini Icons
    {"nvim-mini/mini.icons", version = "*" },
    -- Mini Files
    {
        'nvim-mini/mini.files',
        version = '*',
        keys = {
            {
                '<leader>fm',
                '<cmd>lua require("mini.files").open(vim.api.nvim_buf_get_name(0))<CR>'
            },
        },
        config = function()
            require('mini.files').setup({
                windows = {
                    preview = true,
                    width_focus = 30,
                    width_preview = 50,
                },
            })
        end,
    }
}
