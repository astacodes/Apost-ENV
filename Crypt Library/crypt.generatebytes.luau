function crypt.generatebytes(size)
    local randomBytes = table.create(size)
    for i = 1, size do
        randomBytes[i] = string.char(math.random(0, 255))
    end
    return crypt.base64encode(table.concat(randomBytes))
end