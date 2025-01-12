local telescope = require('telescope.builtin')
local _last_picker = nil
local _last_ctx = nil
local ctx = nil
local function telescope_middleware(func, ctxfunc)
  function inner()
    if ctxfunc == nil then
      ctx = nil
    else
      ctx = ctxfunc()
    end
    if func == _last_picker and vim.deep_equal(ctx, _last_ctx) then
      telescope.resume()
    else
      _last_picker = func
      _last_ctx = ctx
      func()
    end
  end
  return inner
end


return telescope_middleware
