local functions = {}
functions.dump = function (t)
   if type(t) == 'table' then
      local s = '{ '
      for k,v in pairs(t) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. functions.dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(t)
   end
end

functions.get_selected_text = function ()
   vim.cmd('noau normal! "vy"')
   local text = vim.fn.getreg('v')
   vim.fn.setreg('v', {})

   text = string.gsub(text, "\n", "")
   if #text > 0 then
      return text
   else
      return ''
   end
end

return functions
