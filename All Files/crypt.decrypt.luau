function crypt.decrypt(hex, key)
	local result = {}
	key = tostring(key)
	for i = 1, #hex, 2 do
		local byte_str = string.sub(hex, i, i+1)
		local byte = tonumber(byte_str, 16)
		local keyByte = string.byte(key, ((i - 1) // 2) % #key + 1)
		table.insert(result, string.char(bit32.bxor(byte, keyByte)))
	end
	return table.concat(result)
end