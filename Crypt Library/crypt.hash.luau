local function a(b)
    return string.gsub(
        b,
        ".",
        function(c)
            return string.format("%02x", string.byte(c))
        end
    )
end

local function d(e, f)
    local b = ""
    for g = 1, f do
        local h = e % 256
        b = string.char(h) .. b
        e = (e - h) / 256
    end
    return b
end

local function i(b, g)
    local f = 0
    for j = g, g + 3 do
        f = f * 256 + string.byte(b, j)
    end
    return f
end

local function k(l, m)
    local n = 64 - (m + 9) % 64
    m = d(8 * m, 8)
    l = l .. "\128" .. string.rep("\0", n) .. m
    assert(#l % 64 == 0)
    return l
end

local function o(l, g, p)
    local q = {}
    local r = {
        0x428a2f98,
        0x71374491,
        0xb5c0fbcf,
        0xe9b5dba5,
        0x3956c25b,
        0x59f111f1,
        0x923f82a4,
        0xab1c5ed5,
        0xd807aa98,
        0x12835b01,
        0x243185be,
        0x550c7dc3,
        0x72be5d74,
        0x80deb1fe,
        0x9bdc06a7,
        0xc19bf174,
        0xe49b69c1,
        0xefbe4786,
        0x0fc19dc6,
        0x240ca1cc,
        0x2de92c6f,
        0x4a7484aa,
        0x5cb0a9dc,
        0x76f988da,
        0x983e5152,
        0xa831c66d,
        0xb00327c8,
        0xbf597fc7,
        0xc6e00bf3,
        0xd5a79147,
        0x06ca6351,
        0x14292967,
        0x27b70a85,
        0x2e1b2138,
        0x4d2c6dfc,
        0x53380d13,
        0x650a7354,
        0x766a0abb,
        0x81c2c92e,
        0x92722c85,
        0xa2bfe8a1,
        0xa81a664b,
        0xc24b8b70,
        0xc76c51a3,
        0xd192e819,
        0xd6990624,
        0xf40e3585,
        0x106aa070,
        0x19a4c116,
        0x1e376c08,
        0x2748774c,
        0x34b0bcb5,
        0x391c0cb3,
        0x4ed8aa4a,
        0x5b9cca4f,
        0x682e6ff3,
        0x748f82ee,
        0x78a5636f,
        0x84c87814,
        0x8cc70208,
        0x90befffa,
        0xa4506ceb,
        0xbef9a3f7,
        0xc67178f2
    }
    for j = 1, 16 do
        q[j] = i(l, g + (j - 1) * 4)
    end
    for j = 17, 64 do
        local s = q[j - 15]
        local t = bit.bxor(bit.rrotate(s, 7), bit.rrotate(s, 18), bit.rshift(s, 3))
        s = q[j - 2]
        local u = bit.bxor(bit.rrotate(s, 17), bit.rrotate(s, 19), bit.rshift(s, 10))
        q[j] = (q[j - 16] + t + q[j - 7] + u) % 2 ^ 32
    end
    local v, w, c, x, y, z, A, B = p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]
    for g = 1, 64 do
        local t = bit.bxor(bit.rrotate(v, 2), bit.rrotate(v, 13), bit.rrotate(v, 22))
        local C = bit.bxor(bit.band(v, w), bit.band(v, c), bit.band(w, c))
        local D = (t + C) % 2 ^ 32
        local u = bit.bxor(bit.rrotate(y, 6), bit.rrotate(y, 11), bit.rrotate(y, 25))
        local E = bit.bxor(bit.band(y, z), bit.band(bit.bnot(y), A))
        local F = (B + u + E + r[g] + q[g]) % 2 ^ 32
        B = A
        A = z
        z = y
        y = (x + F) % 2 ^ 32
        x = c
        c = w
        w = v
        v = (F + D) % 2 ^ 32
    end
    p[1] = (p[1] + v) % 2 ^ 32
    p[2] = (p[2] + w) % 2 ^ 32
    p[3] = (p[3] + c) % 2 ^ 32
    p[4] = (p[4] + x) % 2 ^ 32
    p[5] = (p[5] + y) % 2 ^ 32
    p[6] = (p[6] + z) % 2 ^ 32
    p[7] = (p[7] + A) % 2 ^ 32
    p[8] = (p[8] + B) % 2 ^ 32
end

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
