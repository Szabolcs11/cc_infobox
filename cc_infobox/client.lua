local sx, sy = guiGetScreenSize()

local dxFontLarge = dxCreateFont("files/font.ttf", 70)
local dxFont = dxCreateFont("files/font.ttf", 30)

notifications = {}

function renderinfobox ()
	for k, v in pairs(notifications) do 
		if (v.State == "start") then 
			v.alphaProgress = (getTickCount() - v.AlphaTick) / 1200
			CurrentY = interpolateBetween (v.StartY, 0, 0, v.EndY, 0, 0, v.alphaProgress, "Linear")

			if (v.alphaProgress >= 2) then 
				v.State = "backward"
				v.Tick = getTickCount()
			end 
		end

		if (v.State == "backward") then 
			v.alphaProgress = (getTickCount() - v.Tick) / 1200
			CurrentY = interpolateBetween (v.EndY, 0, 0, v.StartY-(sy*0.01), 0, 0, v.alphaProgress, "Linear")
		end 

		dxDrawRoundedRectangle(sx*0.3975, CurrentY-(sy*0.005), sx*0.205, sy*0.08, 20, tocolor(65, 34, 138, 180), false, false)
		dxDrawRoundedRectangle(sx*0.4, CurrentY, sx*0.2, sy*0.07, 18, tocolor(100, 100, 100, 180), false, false)
		if (v.Firstline == "") then 
			dxDrawText(v.Text, sx*0.4, CurrentY+(sy*0.01), sx*0.6, sy*0.07, tocolor(v.r, v.g, v.b, 220), 1, v.font, "center")
		else 
			dxDrawText(v.Firstline, sx*0.4, CurrentY-(sy*0.005), sx*0.6, sy*0.07, tocolor(v.r, v.g, v.b, 220), 1, v.font, "center")
			dxDrawText(v.Secoundline, sx*0.4, CurrentY+(sy*0.025), sx*0.6, sy*0.07, tocolor(v.r, v.g, v.b, 220), 1, v.font, "center")
		end 		
	end 
end 
addEventHandler("onClientRender", root, renderinfobox)

function addNotification(player, text, type)
	-- print("1")
	if (player and text and type) then 
		if (player ~= localPlayer) then 
			return false 
		end 
		if (utfLen(text) <= 55) then 
			if (text and type) then
				if (notifications ~= nil) then
					table.remove(notifications, #notifications);
				end

				if (type == 1) then -- Zöld
					r = 60
					g = 232
					b = 115
				end 

				if (type == 2) then -- Error
					r = 232
					g = 26
					b = 1
				end 

				if (type == 3) then -- Warning
					r = 232
					g = 232
					b = 35
				end 

				if (type == 4) then -- Other
					r = 255
					g = 255
					b = 255
				end

				table.insert(notifications,
				{

					Firstline = elsoline(text, 28),
					Secoundline = masodikline(text, 28),
					Text = text, 
					Type = type,
					StartY = -70 ,
					EndY = 54,
					State = 'start',
					Tick = 0,
					AlphaTick = getTickCount(),
					alphaProgress = 0,
					start = getTickCount(),
					r=r,
					g=g,
					b=b,
					font = dxCreateFont("files/font.ttf", 30)

				})	
			end
		else 
			print("Túl hosszú infobox szöveg: "..utfLen(text).." Max: [55]")
		end 
	else 
		print("Hiányos argument az infoboxba")
		print(player)
		print(text)
		print(type)
	end
end
addEvent("infobox", true)
addEventHandler("infobox", root, addNotification)

function elsoline(input, maxlenght)
	local maxlenght = tonumber(maxlenght)
	-- local input = "janos egy modern ember"
	local chararray = {}
	local firstline = ""
	local secoundline = ""
	if (utfLen(input) > maxlenght) then 
		for i=1, utfLen(input) do 
			chararray[i]=utf8.sub(input, i, i)
		end 
		local j = tonumber(maxlenght)
		-- if (chararray[tonumber(maxlenght)] == " ") then
			-- print("15. az space")
		-- else 
			while (j>0) do
				if (chararray[j] == " ") then 
					print(j)
					firstline = utf8.sub(input, 1, tonumber(j))
					secoundline = utf8.sub(input, j+1, tonumber(utfLen(input)))
					break;
				end 
				j=j-1
			end 
		-- end  
		return firstline
	else 
		return ""
	end 
end 

function masodikline(input, maxlenght)
	local maxlenght = tonumber(maxlenght)
	-- local input = "janos egy modern ember"
	local chararray = {}
	local firstline = ""
	local secoundline = ""
	if (utfLen(input) > maxlenght) then 
		for i=1, utfLen(input) do 
			chararray[i]=utf8.sub(input, i, i)
		end 
		local j = tonumber(maxlenght)
		-- if (chararray[tonumber(maxlenght)] == " ") then
			-- print("15. az space")
		-- else 
			while (j>0) do
				if (chararray[j] == " ") then 
					print(j)
					firstline = utf8.sub(input, 1, tonumber(j))
					secoundline = utf8.sub(input, j+1, tonumber(utfLen(input)))
					break;
				end 
				j=j-1
			end 
		-- end  
		return secoundline
	else 
		return ""
	end 
end 


-- // Useful Funkciók \\ -- 

function dxDrawRoundedRectangle(x, y, width, height, radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+radius, width-(radius*2), height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawCircle(x+radius, y+radius, radius, 180, 270, color, color, 16, 1, postGUI)
    dxDrawCircle(x+radius, (y+height)-radius, radius, 90, 180, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, (y+height)-radius, radius, 0, 90, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, y+radius, radius, 270, 360, color, color, 16, 1, postGUI)
    dxDrawRectangle(x, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+height-radius, width-(radius*2), radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+width-radius, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y, width-(radius*2), radius, color, postGUI, subPixelPositioning)
end
