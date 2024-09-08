function checkcaller()
	local info = debug.info(getgenv, 'slnaf')
	return debug.info(1, 'slnaf') == info
end