welcome = {"   ______ ____   ___     ______ __  ___ ______",
           "  / ____// __ \\ /   |   / ____//  |/  // ____/",
           " / / __ / /_/ // /| |  / __/  / /|_/ // __/   ",
           "/ /_/ // _, _// ___ | / /___ / /  / // /___   ",
           "\\____//_/ |_|/_/  |_|/_____//_/  /_//_____/   ",
           "                                              "}

local api = vim.api

local bufid = api.nvim_win_get_buf(0)
local buf = api.nvim_buf_get_name(bufid)

-- Create a intro buffer
local intro = api.nvim_create_buf(false, true)
api.nvim_win_set_buf(0, intro)
vim.cmd "file intro"
api.nvim_win_set_buf(0, bufid)

function resize()
    win_width = api.nvim_win_get_width(0)
    win_height = api.nvim_win_get_height(0)
    line_width = string.len(welcome[1])
    x_start = math.floor((win_width - line_width)/2)
    y_start = math.floor((win_height - 6)/2)

    -- clear buffer
    api.nvim_buf_set_lines(intro, 0, -1, false, {})

    arr = {}

    for i=1,y_start do 
        table.insert(arr, string.rep(" ", win_width))
    end
    for i=1, #welcome do
        table.insert(arr, string.rep(" ", x_start) .. welcome[i] .. string.rep(" ", x_start))
    end

    for i=#arr+1, win_height-1 do 
        table.insert(arr, string.rep(" ", win_width))
    end

    api.nvim_buf_set_lines(intro, 0, 0, false, arr)
    vim.fn.setpos('.', {0, 0, 0, 0})
    vim.cmd "set nomodified"
end


if buf == '' then
    api.nvim_win_set_buf(0, intro)
end

local introGroup = api.nvim_create_augroup("Intro", {clear = false})
api.nvim_create_autocmd("BufEnter",
    {group = introGroup,
     buffer = intro,
     callback=resize})

api.nvim_create_autocmd("WinResized",
    {group = introGroup,
     callback=resize})
