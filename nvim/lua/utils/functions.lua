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

return functions
