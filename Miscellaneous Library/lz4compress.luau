-- This function requires a dependency found in the Dependencies.luau file! It will not function properly without them

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