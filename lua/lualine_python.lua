local function get_venv(variable)
    local venv = os.getenv(variable)
    if venv ~= nil and string.find(venv, "/") then
        local orig_venv = venv
        for w in orig_venv:gmatch("([^/]+)") do
            venv = w
        end
        venv = string.format("%s", venv)
    end
    return venv
end

return {
    "lualine.nvim",
    opts = function(_, opts)
        table.insert(opts.sections.lualine_y, {
            function()
                local venv = get_venv("CONDA_DEFAULT_ENV") or get_venv("VIRTUAL_ENV") or "NO ENV"
                return " " .. venv
            end,
            cond = function()
                return vim.bo.filetype == "python"
            end,
        })
    end,
}
