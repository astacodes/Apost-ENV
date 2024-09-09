type Streamer = {
	Offset: number,
	Source: string,
	Length: number,
	IsFinished: boolean,
	LastUnreadBytes: number,

	read: (Streamer, len: number?, shiftOffset: boolean?) -> string,
	seek: (Streamer, len: number) -> (),
	append: (Streamer, newData: string) -> (),
	toEnd: (Streamer) -> ()
}

type BlockData = {
	[number]: {
		Literal: string,
		LiteralLength: number,
		MatchOffset: number?,
		MatchLength: number?
	}
}

local function plainFind(str, pat)
	return string.find(str, pat, 0, true)
end

local function streamer(str): Streamer
	local Stream = {}
	Stream.Offset = 0
	Stream.Source = str
	Stream.Length = string.len(str)
	Stream.IsFinished = false	
	Stream.LastUnreadBytes = 0

	function Stream.read(self: Streamer, len: number?, shift: boolean?): string
		local len = len or 1
		local shift = if shift ~= nil then shift else true
		local dat = string.sub(self.Source, self.Offset + 1, self.Offset + len)

		local dataLength = string.len(dat)
		local unreadBytes = len - dataLength

		if shift then
			self:seek(len)
		end

		self.LastUnreadBytes = unreadBytes
		return dat
	end

	function Stream.seek(self: Streamer, len: number)
		local len = len or 1

		self.Offset = math.clamp(self.Offset + len, 0, self.Length)
		self.IsFinished = self.Offset >= self.Length
	end

	function Stream.append(self: Streamer, newData: string)
		self.Source ..= newData
		self.Length = string.len(self.Source)
		self:seek(0) 
	end

	function Stream.toEnd(self: Streamer)
		self:seek(self.Length)
	end

	return Stream
end

local drawingUI = Instance.new("ScreenGui")
drawingUI.Name = "Drawing"
drawingUI.IgnoreGuiInset = true
drawingUI.DisplayOrder = 0x7fffffff
drawingUI.Parent = coreGui

local drawingIndex = 0
local uiStrokes = table.create(0)
local baseDrawingObj = setmetatable({
	Visible = true,
	ZIndex = 0,
	Transparency = 1,
	Color = Color3.new(),
	Remove = function(self)
		setmetatable(self, nil)
	end
}, {
	__add = function(t1, t2)
		local result = table.clone(t1)

		for index, value in t2 do
			result[index] = value
		end
		return result
	end
})
local drawingFontsEnum = {
	[0] = Font.fromEnum(Enum.Font.Roboto),
	[1] = Font.fromEnum(Enum.Font.Legacy),
	[2] = Font.fromEnum(Enum.Font.SourceSans),
	[3] = Font.fromEnum(Enum.Font.RobotoMono),
}

local function getFontFromIndex(fontIndex: number): Font
	return drawingFontsEnum[fontIndex]
end

local function convertTransparency(transparency: number): number
	return math.clamp(1 - transparency, 0, 1)
end

local DrawingLib = {}
DrawingLib.Fonts = {
	["UI"] = 0,
	["System"] = 1,
	["Plex"] = 2,
	["Monospace"] = 3
}
local drawings = {}

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

function lz4compress(str: string): string
	local blocks: BlockData = {}
	local iostream = streamer(str)
	if iostream.Length > 12 then
		local firstFour = iostream:read(4)
		local processed = firstFour
		local lit = firstFour
		local match = ""
		local LiteralPushValue = ""
		local pushToLiteral = true
		repeat
			pushToLiteral = true
			local nextByte = iostream:read()
			if plainFind(processed, nextByte) then
				local next3 = iostream:read(3, false)
				if string.len(next3) < 3 then
					LiteralPushValue = nextByte .. next3
					iostream:seek(3)
				else
					match = nextByte .. next3
					local matchPos = plainFind(processed, match)
					if matchPos then
						iostream:seek(3)
						repeat
							local nextMatchByte = iostream:read(1, false)
							local newResult = match .. nextMatchByte

							local repos = plainFind(processed, newResult) 
							if repos then
								match = newResult
								matchPos = repos
								iostream:seek(1)
							end
						until not plainFind(processed, newResult) or iostream.IsFinished
						local matchLen = string.len(match)
						local pushMatch = true
						if iostream.Length - iostream.Offset <= 5 then
							LiteralPushValue = match
							pushMatch = false
						end
						if pushMatch then
							pushToLiteral = false
							local realPosition = string.len(processed) - matchPos
							processed = processed .. match
							table.insert(blocks, {
								Literal = lit,
								LiteralLength = string.len(lit),
								MatchOffset = realPosition + 1,
								MatchLength = matchLen,
							})
							lit = ""
						end
					else
						LiteralPushValue = nextByte
					end
				end
			else
				LiteralPushValue = nextByte
			end
			if pushToLiteral then
				lit = lit .. LiteralPushValue
				processed = processed .. nextByte
			end
		until iostream.IsFinished
		table.insert(blocks, {
			Literal = lit,
			LiteralLength = string.len(lit)
		})
	else
		local str = iostream.Source
		blocks[1] = {
			Literal = str,
			LiteralLength = string.len(str)
		}
	end
	local output = string.rep("\x00", 4)
	local function write(char)
		output = output .. char
	end
	for chunkNum, chunk in blocks do
		local litLen = chunk.LiteralLength
		local matLen = (chunk.MatchLength or 4) - 4
		local tokenLit = math.clamp(litLen, 0, 15)
		local tokenMat = math.clamp(matLen, 0, 15)
		local token = bit32.lshift(tokenLit, 4) + tokenMat
		write(string.pack("<I1", token))
		if litLen >= 15 then
			litLen = litLen - 15
			repeat
				local nextToken = math.clamp(litLen, 0, 0xFF)
				write(string.pack("<I1", nextToken))
				if nextToken == 0xFF then
					litLen = litLen - 255
				end
			until nextToken < 0xFF
		end
		write(chunk.Literal)
		if chunkNum ~= #blocks then
			write(string.pack("<I2", chunk.MatchOffset))
			if matLen >= 15 then
				matLen = matLen - 15
				repeat
					local nextToken = math.clamp(matLen, 0, 0xFF)
					write(string.pack("<I1", nextToken))
					if nextToken == 0xFF then
						matLen = matLen - 255
					end
				until nextToken < 0xFF
			end
		end
	end
	local compLen = string.len(output) - 4
	local decompLen = iostream.Length
	return string.pack("<I4", compLen) .. string.pack("<I4", decompLen) .. output
end

function lz4decompress(lz4data: string): string
	local inputStream = streamer(lz4data)
	local compressedLen = string.unpack("<I4", inputStream:read(4))
	local decompressedLen = string.unpack("<I4", inputStream:read(4))
	local reserved = string.unpack("<I4", inputStream:read(4))
	if compressedLen == 0 then
		return inputStream:read(decompressedLen)
	end
	local outputStream = streamer("")
	repeat
		local token = string.byte(inputStream:read())
		local litLen = bit32.rshift(token, 4)
		local matLen = bit32.band(token, 15) + 4
		if litLen >= 15 then
			repeat
				local nextByte = string.byte(inputStream:read())
				litLen += nextByte
			until nextByte ~= 0xFF
		end
		local literal = inputStream:read(litLen)
		outputStream:append(literal)
		outputStream:toEnd()
		if outputStream.Length < decompressedLen then
			local offset = string.unpack("<I2", inputStream:read(2))
			if matLen >= 19 then
				repeat
					local nextByte = string.byte(inputStream:read())
					matLen += nextByte
				until nextByte ~= 0xFF
			end
			outputStream:seek(-offset)
			local pos = outputStream.Offset
			local match = outputStream:read(matLen)
			local unreadBytes = outputStream.LastUnreadBytes
			local extra
			if unreadBytes then
				repeat
					outputStream.Offset = pos
					extra = outputStream:read(unreadBytes)
					unreadBytes = outputStream.LastUnreadBytes
					match ..= extra
				until unreadBytes <= 0
			end
			outputStream:append(match)
			outputStream:toEnd()
		end
	until outputStream.Length >= decompressedLen
	return outputStream.Source
end
