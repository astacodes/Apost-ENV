function crypt.encrypt(plaintext, key)
	local result = {}
	plaintext = tostring(plaintext)
	key = tostring(key)
	for i = 1, #plaintext do
		local byte = string.byte(plaintext, i)
		local keyByte = string.byte(key, (i - 1) % #key + 1)
		table.insert(result, string.format("%02X", bit32.bxor(byte, keyByte)))
	end
	return table.concat(result)
end