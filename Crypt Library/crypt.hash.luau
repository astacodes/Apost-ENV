-- This function requires a dependency found in the Dependencies.luau file! It will not function properly without them

function crypt.hash(l)
    l = k(l, #l)
    local p = {0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19}
    for g = 1, #l, 64 do
        o(l, g, p)
    end
    return a(
        d(p[1], 4) .. d(p[2], 4) .. d(p[3], 4) .. d(p[4], 4) .. d(p[5], 4) .. d(p[6], 4) .. d(p[7], 4) .. d(p[8], 4)
    )
end