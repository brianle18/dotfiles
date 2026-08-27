-- Freeze the leading CSV column(s) in a scroll-bound side pane.
--
-- csvview.nvim pins the header *row* (`view.sticky_header`) but has no notion of
-- a frozen column, so scrolling right loses your row labels. Rather than mirror
-- csvview's rendering into a float -- which would mean reproducing its column
-- width, spacing and multiline-row maths -- this shows the *same buffer* in a
-- narrow window on the left and ties the two together with 'scrollbind'.
--
-- Same buffer means the same extmarks, so row alignment is exact for free, even
-- with quoted multi-line fields. 'scrollopt' defaults to "ver,jump", so vertical
-- scrolling syncs while horizontal stays independent -- which is the whole trick.

local M = {}

--- main window id -> frozen pane window id
M._panes = {}

--- Screen width of the first `ncols` columns as csvview actually renders them.
---
-- Measured rather than computed: we ask csvview to jump to the start of the
-- next column and read the cursor's screen position. `screenpos()` accounts for
-- inline virtual text, so this picks up alignment padding, `view.spacing` and
-- `display_mode = "border"` without reimplementing any of it.
---@param win integer
---@param ncols integer
---@return integer? width, string? err
local function frozen_width(win, ncols)
    local ok, jump = pcall(require, "csvview.jump")
    if not ok then
        return nil, "csvview is not available"
    end

    local saved = vim.api.nvim_win_call(win, vim.fn.winsaveview)
    local lnum = vim.api.nvim_win_call(win, function()
        return vim.fn.line("w0")
    end)

    local measured, err = nil, nil
    vim.api.nvim_win_call(win, function()
        local jumped = pcall(jump.field, 0, {
            pos = { lnum, ncols + 1 },
            mode = "absolute",
            anchor = "start",
        })
        if not jumped then
            err = "could not locate column " .. (ncols + 1)
            return
        end

        local cursor = vim.api.nvim_win_get_cursor(win)
        local pos = vim.fn.screenpos(win, cursor[1], cursor[2] + 1)
        if pos.curscol == 0 then
            err = "column " .. (ncols + 1) .. " is off screen"
            return
        end

        -- curscol is absolute; strip the window's own left edge and its
        -- number/sign/fold gutter to get a width in text columns.
        local info = vim.fn.getwininfo(win)[1]
        measured = pos.curscol - info.wincol - info.textoff
    end)

    vim.api.nvim_win_call(win, function()
        vim.fn.winrestview(saved)
    end)

    if err then
        return nil, err
    end
    if not measured or measured < 1 then
        return nil, "measured a nonsensical width (" .. tostring(measured) .. ")"
    end
    return measured
end

--- @param win integer
local function close_pane(win)
    local pane = M._panes[win]
    M._panes[win] = nil
    if pane and vim.api.nvim_win_is_valid(pane) then
        vim.api.nvim_win_close(pane, true)
    end
    if vim.api.nvim_win_is_valid(win) then
        vim.wo[win].scrollbind = false
    end
end

--- @param win integer
--- @param ncols integer
local function open_pane(win, ncols)
    local width, err = frozen_width(win, ncols)
    if not width then
        vim.notify("CsvFreezeColumn: " .. err, vim.log.levels.ERROR)
        return
    end

    local pane
    vim.api.nvim_win_call(win, function()
        vim.cmd("leftabove vsplit")
        pane = vim.api.nvim_get_current_win()
    end)

    vim.api.nvim_win_set_width(pane, width)
    local wo = vim.wo[pane]
    wo.winfixwidth = true
    wo.wrap = false
    wo.number = false
    wo.relativenumber = false
    wo.signcolumn = "no"
    wo.foldcolumn = "0"
    wo.cursorline = false

    -- Bind after both windows are configured, then force an initial alignment.
    vim.wo[win].wrap = false
    vim.wo[win].scrollbind = true
    wo.scrollbind = true
    vim.api.nvim_win_call(pane, function()
        vim.cmd("syncbind")
    end)

    M._panes[win] = pane
end

--- Toggle the frozen pane for the current window.
--- @param ncols? integer number of leading columns to freeze (default 1)
function M.toggle(ncols)
    local win = vim.api.nvim_get_current_win()

    -- Toggling from inside the pane should close it, not stack another one.
    for main, pane in pairs(M._panes) do
        if pane == win then
            close_pane(main)
            return
        end
    end

    if M._panes[win] then
        close_pane(win)
    else
        open_pane(win, ncols or 1)
    end
end

-- Drop bookkeeping when either half is closed by hand (:q, :only, ...).
vim.api.nvim_create_autocmd("WinClosed", {
    group = vim.api.nvim_create_augroup("CsvFreezeColumn", { clear = true }),
    callback = function(ev)
        local closed = tonumber(ev.match)
        for main, pane in pairs(M._panes) do
            if main == closed then
                M._panes[main] = nil
                if vim.api.nvim_win_is_valid(pane) then
                    vim.api.nvim_win_close(pane, true)
                end
            elseif pane == closed then
                M._panes[main] = nil
                if vim.api.nvim_win_is_valid(main) then
                    vim.wo[main].scrollbind = false
                end
            end
        end
    end,
})

vim.api.nvim_create_user_command("CsvFreezeColumn", function(o)
    M.toggle(tonumber(o.args))
end, { nargs = "?", desc = "Toggle a scroll-bound pane freezing the leading CSV column(s)" })

return M
