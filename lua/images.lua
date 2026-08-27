-- View images from URLs.
--
-- snacks.image already handles `:e https://host/pic.png` via its BufReadCmd,
-- but it decides support from the file extension alone -- so URLs with a query
-- string ("pic.png?raw=1") or no extension at all fall through. :ImageUrl
-- downloads first and picks the extension from the Content-Type instead.

local content_types = {
    ["image/png"] = "png",
    ["image/jpeg"] = "jpg",
    ["image/gif"] = "gif",
    ["image/webp"] = "webp",
    ["image/svg+xml"] = "svg",
    ["image/bmp"] = "bmp",
    ["image/tiff"] = "tiff",
    ["image/avif"] = "avif",
    ["image/heic"] = "heic",
    ["application/pdf"] = "pdf",
}

local cache = vim.fn.stdpath("cache") .. "/image-url"

-- Extension from the URL path, ignoring any query string or fragment.
local function url_ext(url)
    local path = url:gsub("[?#].*$", "")
    return path:match("%.([%a%d]+)$")
end

-- The URL the cursor is sitting on, or nil. `<cfile>` isn't reliable here --
-- it obeys 'isfname', which cuts URLs short at "?" and friends.
local function url_under_cursor()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1
    local from = 1

    while true do
        local s, e = line:find("https?://[^%s\"'<>`|{}%^\\]+", from)
        if not s then
            return nil
        end
        if col >= s and col <= e then
            local url = line:sub(s, e)
            -- Trim trailing punctuation the URL almost certainly doesn't own.
            -- A ")" is only dropped when unbalanced, so markdown ![](url) is
            -- handled without breaking URLs that legitimately contain parens.
            url = url:gsub("[%.,;:!?>%]]+$", "")
            if url:sub(-1) == ")" then
                local _, opens = url:gsub("%(", "")
                local _, closes = url:gsub("%)", "")
                if closes > opens then
                    url = url:sub(1, -2)
                end
            end
            return url
        end
        from = e + 1
    end
end

-- Compare resolved paths: nvim stores buffer names with symlinks resolved.
local function buf_named(file)
    local target = vim.fn.resolve(file)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.fn.resolve(vim.api.nvim_buf_get_name(buf)) == target then
            return buf
        end
    end
end

local function show(file)
    -- Reuse the buffer if this URL has been viewed before. Closing the split
    -- only hides the buffer, and buffer names must be unique -- so naming a
    -- fresh buffer after the same cached file would fail with E95. Attaching
    -- twice is fine: snacks cleans existing placements first.
    local buf = buf_named(file)

    -- `vertical rightbelow` rather than plain `vnew`, so the pane lands on the
    -- right regardless of 'splitright'.
    if buf then
        vim.cmd("vertical rightbelow sbuffer " .. buf)
    else
        vim.cmd("vertical rightbelow new")
        buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_name(buf, file)
    end

    require("snacks.image.buf").attach(buf, { src = file })
end

local function open_url(url)
    vim.fn.mkdir(cache, "p")
    local tmp = cache .. "/" .. vim.fn.sha256(url):sub(1, 16)

    vim.system(
        { "curl", "-sL", "--max-time", "30", "-w", "%{content_type}", "-o", tmp, url },
        { text = true },
        vim.schedule_wrap(function(res)
            if res.code ~= 0 then
                vim.notify("ImageUrl: curl exited " .. res.code, vim.log.levels.ERROR)
                return
            end

            -- Trust the server over the URL: a ".png" that serves JPEG is common.
            -- Only fall back to the extension when the type is uninformative --
            -- an error page served for a ".png" URL should fail, not render.
            local ct = vim.trim(res.stdout or ""):gsub(";.*$", "")
            local ext = content_types[ct]
            if not ext and (ct == "" or ct:find("octet%-stream$")) then
                ext = url_ext(url)
            end
            if not ext then
                vim.notify("ImageUrl: not an image (Content-Type: " .. ct .. ")", vim.log.levels.ERROR)
                return
            end

            local file = tmp .. "." .. ext
            local ok, err = vim.uv.fs_rename(tmp, file)
            if not ok then
                vim.notify("ImageUrl: " .. tostring(err), vim.log.levels.ERROR)
                return
            end
            show(file)
        end)
    )
end

vim.api.nvim_create_user_command("ImageUrl", function(o)
    open_url(o.args)
end, { nargs = 1, desc = "Download an image from a URL and view it" })

vim.keymap.set("n", "<leader>iv", function()
    local url = url_under_cursor()
    if not url then
        vim.notify("ImageUrl: no URL under the cursor", vim.log.levels.WARN)
        return
    end
    open_url(url)
end, { desc = "View image URL under cursor" })
