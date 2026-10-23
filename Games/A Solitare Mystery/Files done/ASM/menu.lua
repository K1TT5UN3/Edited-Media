menulist =
{
	main =
	{
		enter = function()
			local scount = 0
			for i,v in pairs(SPRITES) do
				scount = scount + 1
			end
			textsys.write("Version " .. GAME.version .. " (" .. tostring(#UNITS) .. ", " .. tostring(scount) .. ")",8,8,"main")
			
			textsys.write("Sort solitaires:",8,30,"main")
			local e1,e2,e3,e4 = false,false,false,false
			if (sortmode == 0) then
				e1 = true
			elseif (sortmode == 1) then
				e2 = true
			elseif (sortmode == 2) then
				e3 = true
			elseif (sortmode == 3) then
				e4 = true
			end
			
			menusys.button.create("sort_normal",32,48,"ui",{_text = "Default", w = 48, h = 18, disabled = e1})
			menusys.button.create("sort_diff",32,68,"ui",{_text = "Difficulty", w = 48, h = 18, disabled = e2})
			menusys.button.create("sort_wins",32,88,"ui",{_text = "Wins", w = 48, h = 18, disabled = e3})
			menusys.button.create("sort_rec",32,108,"ui",{_text = "Recent", w = 48, h = 18, disabled = e4})
			
			local save = filesys.ini.open("save.txt")
			local thumb = unitsys.create("thumbnail","thumb",screenw * 0.5,screenh * 0.5 - 88)
			local alternatemusic_ = true
			
			local icons = SCRIPT_MODS
			local increment = (screenw - 84) / (#icons - 1)
			local unsorted = {}
			local sorted_ = {}
			sorted = {}
			for i,v in ipairs(icons) do
				--local x = 32 + (i-1) * 56
				local x = 0
				local y = screenh - 48
				
				local icon = unitsys.create("icon",v,x,y,{_anim = v, oy = y})
				table.insert(unsorted, icon)
				
				local data = subgames[v] or {}
				icon.title = data.title or "NONE"
				icon.titlecol = data.title_colour or "ffffff"
				icon.desc = data.desc or "Text redacted."
				icon.rating = data.rating or "-----"
				icon.ratingnum = 0
				for a=1,#icon.rating do
					local l = string.sub(icon.rating, a, a)
					if (l == "*") then
						icon.ratingnum = icon.ratingnum + 1
					end
				end
				icon.deck = data.deck or "-"
				icon.back = data.back_colour or 0x3f547c
				icon.wins = save:read("wins",v) or "0"
				icon.mstreak = save:read("mstreak",v) or "0"
				icon.prizes = {}
				icon.music = data.music or "asm_baba"
				icon.noundo = data.noundo or false
				
				local wins_ = tonumber(icon.wins) or 0
				local mstreak_ = tonumber(icon.mstreak) or 0
				
				if (wins_ > 0) then
					icon.prizes.a = unitsys.create("prize","a",-16,-16,{_anim = "a"})
				end
				
				if (wins_ > 4) then
					icon.prizes.b = unitsys.create("prize","b",-16,-16,{_anim = "b"})
				end
				
				if (wins_ > 9) then
					icon.prizes.c = unitsys.create("prize","c",-16,-16,{_anim = "c"})
				end
				
				if (mstreak_ > 1) then
					icon.prizes.double = unitsys.create("prize","double",-16,-16,{_anim = "double"})
				else
					alternatemusic_ = false
				end
				
				spritesys.zlayer.toback(icon)
			end
			
			if (sortmode == 0) then
				sorted_ = unsorted
			elseif (sortmode == 1) then
				sorted_ = sortlist(unsorted,"ratingnum")
			elseif (sortmode == 2) then
				sorted_ = sortlist(unsorted,"wins")
			elseif (sortmode == 3) then
				local rec = save:read("recent","recent") or ""
				local wf = {}
				for w in string.gmatch(rec, "%S+") do
					if (wf[w] == nil) then
						table.insert(sorted, w)
						wf[w] = 1
					end
				end
				for i,v in ipairs(icons) do
					if (wf[v] == nil) then
						table.insert(sorted, v)
					end
				end
				sorted_ = {}
			end
			
			for i,v in ipairs(sorted_) do
				-- local x = 42 + (i-1) * increment
				-- v.x = x
				table.insert(sorted, v.name)
			end
			
			save:store("save.txt")
			
			local x = screenw - 20
			local y = 20
			menusys.button.create("close",x,y,"ui",{_sprite = "button", _anim = "close", w = 18, h = 18})
			menusys.button.create("setup",x - 24,y,"ui",{_sprite = "button", _anim = "setup", w = 18, h = 18})
			menusys.button.create("credits",x - 64,y,"ui",{_text = "Credits", w = 48, h = 18})
			menusys.button.create("random",x - 120,y,"ui",{_text = "Random", w = 48, h = 18})
			
			if alternatemusic_ then
				alternatemusic = math.max(1, alternatemusic)
				achievement("unlocksecret")
			end
		end,
		
		button_sort_normal = function(unit,mousebutton,key)
			if (mousebutton == 1) then
				local setup = filesys.ini.open("settings.txt")
				sortmode = 0
				setup:write("settings","sort",tostring(sortmode))
				setup:store("settings.txt")
				delay = 5
				
				menusys.button.erase()
				textsys.erase()
				unitsys.reset()
				audiosys.play("beep2")
				menusys.refresh()
			end
		end,
		
		button_sort_diff = function(unit,mousebutton,key)
			if (mousebutton == 1) then
				local setup = filesys.ini.open("settings.txt")
				sortmode = 1
				setup:write("settings","sort",tostring(sortmode))
				setup:store("settings.txt")
				delay = 5
				
				menusys.button.erase()
				textsys.erase()
				unitsys.reset()
				audiosys.play("beep2")
				menusys.refresh()
			end
		end,
		
		button_sort_wins = function(unit,mousebutton,key)
			if (mousebutton == 1) then
				local setup = filesys.ini.open("settings.txt")
				sortmode = 2
				setup:write("settings","sort",tostring(sortmode))
				setup:store("settings.txt")
				delay = 5
				
				menusys.button.erase()
				textsys.erase()
				unitsys.reset()
				audiosys.play("beep2")
				menusys.refresh()
			end
		end,
		
		button_sort_rec = function(unit,mousebutton,key)
			if (mousebutton == 1) then
				local setup = filesys.ini.open("settings.txt")
				sortmode = 3
				setup:write("settings","sort",tostring(sortmode))
				setup:store("settings.txt")
				delay = 5
				
				menusys.button.erase()
				textsys.erase()
				unitsys.reset()
				audiosys.play("beep2")
				menusys.refresh()
			end
		end,
		
		update = function()
			local icons = sorted
			local mx,my = love.mouse.getPosition()
			mx = mx / scaling
			my = my / scaling
			local padding = 42
			local screenw_padded = screenw - (padding * 2)
			local mxpercent = math.min(math.max((mx - padding) / screenw_padded, 0), 1)
			local width = (#icons * 48 + (#icons-1) * 8) - screenw + 16
			local startx = 32
			
			for i,v in ipairs(icons) do
				local unit = unitsys.find("icon",v)
				
				unit.x = startx + (i-1) * 56 - (width * mxpercent)
				
				for a,b in pairs(unit.prizes) do
					local ox = 0
					
					if (a == "a") then
						ox = -18
					elseif (a == "b") then
						ox = -6
					elseif (a == "c") then
						ox = 6
					elseif (a == "double") then
						ox = 18
					end
					
					b.x = unit.x + ox
					b.y = unit.y - 46
					
					if (b.yp < 0) then
						b.xp = unit.xp + ox
						b.yp = unit.yp - 46
					end
				end
			end
		end,
		
		input = "main",
		
		button_credits = function(unit,mousebutton,key)
			textsys.erase("info")
			menusys.button.erase("game")
			audiosys.play("beep2")
			
			local thumb = unitsys.find("thumbnail")
			spritesys.anim.set(thumb.sprite,"start")
			thumb.sprite.visible = false
			
			local x = screenw * 0.5
			local y = 28
			
			local credits_text =
			{
				"Meow",
				"Meow",
				"Meow",
				'Meow',
				"Meow",
			}
			
			local credits_leftmargin =
			{
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
			}
			
			local credits_rightmargin =
			{
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
				"Meow",
			}
			
			textsys.write(credits_text,x,y,"info",{gap = 1, xoffset = -0.5})
			
			y = y + 56
			textsys.write(credits_leftmargin,x - 260,y,"info",{gap = 1, xoffset = 0.0})
			textsys.write(credits_rightmargin,x + 260,y,"info",{gap = 1, xoffset = -1.0})
		end,
		
		button_start = function(unit,mousebutton,key)
			if (mousebutton == 1) then
				delay = 5
				local icon = vars.selected
				menusys.sub("ingame")
				vars.selected = nil
				game = icon.name
				BACKCOL = icon.back
				
				local setup = filesys.ini.open("settings.txt")
				local mus = setup:read("music",game)
				local music = mus or icon.music
				gamemusic = music
				
				local m = getmusic(music)
				audiosys.addevent(m,"changetrack")
				startgame(icon.name)
				
				gamehasundo = true
				if icon.noundo then
					gamehasundo = false
				end
				
				local margin_ = 0
				local marginy_ = 0
				if (game == "solar") then
					margin_ = margin
					marginy_ = marginy
				end
				
				local x = screenw - margin_ - 20
				local y = 20 + marginy_
				
				menusys.button.create("close",x,y,"ui",{_sprite = "button", _anim = "close", w = 18, h = 18})
				x = x - 20
				menusys.button.create("restart",x,y,"ui",{_sprite = "button", _anim = "restart", w = 18, h = 18})
				x = x - 20
				
				if (scripts.info ~= nil) then
					menusys.button.create("info",x,y,"ui",{_sprite = "button", _anim = "info", w = 18, h = 18})
					x = x - 20
				end
				
				if (scripts.autostack ~= nil) then
					menusys.button.create("stack",x,y,"ui",{_sprite = "button", _anim = "stack", w = 18, h = 18})
					x = x - 20
				end
				
				if (undomode ~= 2) and gamehasundo then
					local dis = false
					if (undomode == 1) then
						dis = true
					end
					menusys.button.create("undo",x,y,"ui",{_sprite = "button", _anim = "undo", w = 18, h = 18, disabled = dis})
					x = x - 20
				end
				
				menusys.button.create("music",x,y,"ui",{_sprite = "button", _anim = "music", w = 18, h = 18, disabled = dis})
				x = x - 20
				
				audiosys.play("start")
			end
		end,
		
		button_close = function(unit,mousebutton,key)
			if (mousebutton == 1) then
				love.event.quit()
			end
		end,
		
		button_random = function(unit,mousebutton,key)
			if (mousebutton == 1) then
				local u_ = unitsys.findall("icon")
				if (#u_ > 0) then
					local rnd = math.random(1,#u_)
					local u = u_[rnd]
					showgame(u)
				end
				audiosys.play("beep2")
				delay = 5
			end
		end,
		
		button_setup = function(unit,mousebutton,key)
			if (mousebutton == 1) then
				menusys.change("setup")
				
				audiosys.play("beep2")
			end
		end,
		
		structure =
		{
			
		},
	},
	
	ingame =
	{
		--[[
		enter_submenu = function()
			inputsys.set(inputlist.ingame)
		end,
		]]--
		
		input = "ingame",
		
		enter = function()
			targetcard = nil
			targetpile = nil
		end,
		
		update = function()
			if (vars.victory == 0) then
				targetcard = nil
				targetpile = nil
				local h = inputsys.gethover()
				local highest = 0
				
				if (scripts.hover == nil) then
					for i,unit in ipairs(h) do
						if (unit.class == "card") and (unit.pile ~= "hand") and (unit.sprite ~= nil) and unit.sprite.visible then
							if (unit.zlayer > highest) then
								highest = unit.zlayer
								targetcard = unit
								
								if (#unit.pile > 0) and (unit.pileid > 0) then
									targetpile = unit.pile
								end
							end
						end
						
						if (unit.class == "pile") and (unit.name ~= "hand") and (targetpile == nil) and (unit.open or (unit.open_place and (#piles.hand.cards > 0)) or (unit.open_pick and (#piles.hand.cards == 0))) then
							targetpile = unit.name
						end
					end
				else
					scripts.hover(h)
				end
				
				if (highmode == 0) then
					if (piles ~= nil) and (piles.hand ~= nil) and (scripts.hovereffect ~= nil) then
						if hoverfx and (#piles.hand.cards == 0) then
							unitsys.remove_byclass("hoverfx")
							hoverfx = false
						elseif (hoverfx == false) and (#piles.hand.cards > 0) then
							scripts.hovereffect()
							hoverfx = true
						end
					end
				end
				
				if (scripts.positioning == nil) then
					for i,unit in ipairs(UNITS) do
						if (unit.class == "card") then
							if (#unit.pile > 0) and (unit.pileid > 0) then
								local pile = unitsys.find("pile",unit.pile)
								local ox,oy = pile.card_offsets[1],pile.card_offsets[2]
								
								local hox,hoy = 0,0
								local lerp = 0.2
								if (unit.pile == "hand") then
									hox = 0 - piles.hand.hold_offsets[1]
									hoy = 0 - piles.hand.hold_offsets[2]
									lerp = 0.9
								end
								unit.lerp = lerp
								
								if (pile ~= nil) then
									unit.x = pile.x + (unit.pileid-1) * ox + hox
									unit.y = pile.y + (unit.pileid-1) * oy + hoy
								end
							end
							
							if (scripts.card_pos ~= nil) then
								scripts.card_pos(unit)
							end
						end
					end
				else
					scripts.positioning()
				end
				
				if (scripts.gameflow ~= nil) then
					scripts.gameflow()
				end
			else
				if (scripts.victory_effect ~= nil) then
					scripts.victory_effect()
				else
					unitsys.create("fx_glitter","fade_blue",math.random(0, screenw),math.random(0, screenh),{delete_after_anim = true, layer = 2, xv = math.random(-5,5) * 0.1, yv = math.random(-5,5) * 0.1})
				end
			end
			
			local mx,my = love.mouse.getPosition()
			piles.hand.x = mx / scaling
			piles.hand.y = my / scaling
		end,
		
		draw = function()
			if (vars.victory == 1) and (scripts.victoryeffect ~= nil) then
				scripts.victoryeffect()
			end
		end,
		
		leave = function()
			vars.victory = 0
		end,
		
		structure =
		{
			
		},
	},
	
	info =
	{
		enter = function()
			menusys.button.disable("ui",false)
			
			if (ORDER[2] == nil) then
				ORDER[2] = {}
			end
			
			ORDER[3] = {}
			local o = ORDER[3]
			local c = getrgb(BACKCOL)
			o.effect = function() love.graphics.setColor(c) love.graphics.rectangle("fill", 0, 0, screenw * scaling, screenh * scaling) love.graphics.setColor(1, 1, 1, 1) end
			menusys.button.create("closeinfo",screenw - 20,20,"info",{_sprite = "button", _anim = "close", w = 24, h = 24, layer = #ORDER})
			
			local gdata = subgames[game] or {}
			local gname = gdata.title or "ERROR"
			textsys.write(gname .. " RULES:",16,16,"info",{layer = 3, font = "header"})
			scripts.info(3)
		end,
		
		button_closeinfo = function()
			menusys.button.erase("info")
			textsys.erase("info")
			unitsys.remove_byclass("info")
			menusys.button.enable("ui",true)
			ORDER[3] = nil
			menusys.close()
			
			audiosys.play("error2")
		end,
	},
	
	setup =
	{
		enter = function()
			menusys.button.erase()
			textsys.erase()
			unitsys.reset()
			spritesys.init()
			
			local x = screenw - 20
			local y = 20
			menusys.button.create("closesetup",x,y,"setup",{_sprite = "button", _anim = "close", w = 18, h = 18})
			
			x = 64
			y = 16
			textsys.write("SETTINGS:",x,y,"setup",{font = "header"})
			y = y + 16
			local w,h,f = love.window.getMode()
			local text = textsys.write("Window size: $Ce3c188" .. tostring(w) .. "x" .. tostring(h),x,y,"setup",{font = "header"})
			y = y + 16
			text = textsys.write("Window size multiplier: $Ce3c188x" .. tostring(scaling),x,y,"setup",{font = "header"})
			menusys.button.create("x1",x + text.w + 15,y + 6,"setup",{_text = "x1", _font = "header", w = 14, h = 14})
			menusys.button.create("x2",x + text.w + 37,y + 6,"setup",{_text = "x2", _font = "header", w = 14, h = 14})
			menusys.button.create("x3",x + text.w + 59,y + 6,"setup",{_text = "x3", _font = "header", w = 14, h = 14})
			y = y + 16
			local fscreen = "$Cc56f68Disabled"
			if f.fullscreen then
				fscreen = "$Ca7d962Enabled"
			end
			text = textsys.write("Fullscreen: " .. fscreen,x,y,"setup",{font = "header"})
			menusys.button.create("fscreen_on",x + text.w + 32,y + 6,"setup",{_text = "Enable", _font = "header", w = 48, h = 14})
			menusys.button.create("fscreen_off",x + text.w + 92,y + 6,"setup",{_text = "Disable", _font = "header", w = 48, h = 14})
			y = y + 16
			local fint = "$Ca7d962Enabled"
			if (fscreen_int == 1) then
				fint = "$Cc56f68Disabled"
			end
			text = textsys.write("Stretch pixels in fullscreen mode: " .. fint,x,y,"setup",{font = "header"})
			menusys.button.create("fint_on",x + text.w + 32,y + 6,"setup",{_text = "Enable", _font = "header", w = 48, h = 14})
			menusys.button.create("fint_off",x + text.w + 92,y + 6,"setup",{_text = "Disable", _font = "header", w = 48, h = 14})
			y = y + 16
			local mvol = math.floor(VOLUMES.music * 100)
			text = textsys.write("Music volume:",x,y,"setup",{font = "header"})
			menusys.button.create_slider("music",x + 92 + 12,y + 6,"setup",{w = 168, h = 12, slider_value = mvol, _sprite = "slider"})
			y = y + 16
			local svol = math.floor(VOLUMES.sfx * 100)
			text = textsys.write("SFX volume:",x,y,"setup",{font = "header"})
			menusys.button.create_slider("sound",x + 92 + 12,y + 6,"setup",{w = 168, h = 12, slider_value = svol, _sprite = "slider"})
			y = y + 16
			local focus = "$Cc56f68No"
			if (AUDIOFOCUSMODE == 1) then
				focus = "$Ca7d962Yup"
			end
			text = textsys.write("Pause audio when the game loses focus: " .. focus,x,y,"setup",{font = "header"})
			menusys.button.create("focus_yes",x + text.w + 32,y + 6,"setup",{_text = "On", _font = "header", w = 48, h = 14})
			menusys.button.create("focus_no",x + text.w + 92,y + 6,"setup",{_text = "Off", _font = "header", w = 48, h = 14})
			y = y + 16
			local prompt = "$Cc56f68Nope"
			if (promptmode == 1) then
				prompt = "$Ca7d962Yeah"
			end
			text = textsys.write("Prompt on restart and exit: " .. prompt,x,y,"setup",{font = "header"})
			menusys.button.create("prompt_yes",x + text.w + 32,y + 6,"setup",{_text = "On", _font = "header", w = 48, h = 14})
			menusys.button.create("prompt_no",x + text.w + 92,y + 6,"setup",{_text = "Off", _font = "header", w = 48, h = 14})
			y = y + 24
			
			local seeding = "$Cc56f68Nope"
			if RANDOMSEED.seeding then
				seeding = "$Ca7d962Yeah"
			end
			text = textsys.write("Use the same random seed for each game: " .. seeding,x,y,"setup",{font = "header"})
			menusys.button.create("seed",x + text.w + 32,y + 6,"setup",{_text = "Enable", _font = "header", w = 48, h = 14})
			menusys.button.create("noseed",x + text.w + 92,y + 6,"setup",{_text = "Disable", _font = "header", w = 48, h = 14})
			y = y + 16
			text = textsys.write("Seed value: $Ca7d962" .. tostring(RANDOMSEED.seed),x,y,"setup",{font = "header"})
			y = y + 16
			text = textsys.write("You can copy/paste seeds during gameplay with $Ca7d962Control + C$CW/$Ca7d962Control + V$CW",x,y,"setup")
			y = y + 16
			menusys.button.create("pasteseed",x + 48,y + 6,"setup",{_text = "Paste from clipboard", w = 96, h = 14})
			menusys.button.create("copyseed",x + 160,y + 6,"setup",{_text = "Copy to clipboard", w = 96, h = 14})
			y = y + 24
			local undo = "$Ca7d962Unlimited"
			if (undomode == 1) then
				undo = "$Ce7d962One step at a time"
			elseif (undomode == 2) then
				undo = "$Cc56f68Roguelike (no undo)"
			end
			text = textsys.write("Undo mode: " .. undo,x,y,"setup",{font = "header"})
			menusys.button.create("undo_no",x + text.w + 32,y + 6,"setup",{_text = "No", _font = "header", w = 48, h = 14})
			menusys.button.create("undo_one",x + text.w + 92,y + 6,"setup",{_text = "Once", _font = "header", w = 48, h = 14})
			menusys.button.create("undo_yes",x + text.w + 152,y + 6,"setup",{_text = "Unlimited", _font = "header", w = 48, h = 14})
			y = y + 16
			local high = "$Ca7d962On"
			if (highmode == 1) then
				high = "$Cc56f68Off"
			end
			text = textsys.write("Highlight card placement options: " .. high,x,y,"setup",{font = "header"})
			menusys.button.create("high_yes",x + text.w + 32,y + 6,"setup",{_text = "On", _font = "header", w = 48, h = 14})
			menusys.button.create("high_no",x + text.w + 92,y + 6,"setup",{_text = "Off", _font = "header", w = 48, h = 14})
			y = y + 16
			local spr = "$Cc56f68Hold"
			if (spreadmode > 0) then
				spr = "$Ca7d962Toggle"
			end
			text = textsys.write("Middle mouse button spreads card stacks: " .. spr,x,y,"setup",{font = "header"})
			menusys.button.create("spr_yes",x + text.w + 32,y + 6,"setup",{_text = "Toggle", _font = "header", w = 48, h = 14})
			menusys.button.create("spr_no",x + text.w + 92,y + 6,"setup",{_text = "Hover", _font = "header", w = 48, h = 14})
			y = y + 16
			local rom = "$Ca7d962On"
			if (numeralmode == 1) then
				rom = "$Cc56f68Off"
			end
			text = textsys.write("Roman numerals: " .. rom,x,y,"setup",{font = "header"})
			menusys.button.create("rom_yes",x + text.w + 32,y + 6,"setup",{_text = "On", _font = "header", w = 48, h = 14})
			menusys.button.create("rom_no",x + text.w + 92,y + 6,"setup",{_text = "Off", _font = "header", w = 48, h = 14})
			y = y + 16
			local cb = "$Cc56f68Off"
			if colourblindmode then
				cb = "$Ca7d962On"
			end
			text = textsys.write("Colourblindness-friendlier cards: " .. cb,x,y,"setup",{font = "header"})
			menusys.button.create("cb_yes",x + text.w + 32,y + 6,"setup",{_text = "On", _font = "header", w = 48, h = 14})
			menusys.button.create("cb_no",x + text.w + 92,y + 6,"setup",{_text = "Off", _font = "header", w = 48, h = 14})
			y = y + 16
			local streakstatus= "$Ca7d962On"
			if (streakmode == 1) then
				streakstatus = "$Cc56f68Off"
			end
			text = textsys.write("Display win streaks: " .. streakstatus,x,y,"setup",{font = "header"})
			menusys.button.create("streak_yes",x + text.w + 32,y + 6,"setup",{_text = "On", _font = "header", w = 48, h = 14})
			menusys.button.create("streak_no",x + text.w + 92,y + 6,"setup",{_text = "Off", _font = "header", w = 48, h = 14})
			
			if (alternatemusic > 0) then
				y = y + 16
				local am = "$Cc56f68Off"
				if (alternatemusic == 1) then
					am = "$Ca7d962On"
				end
				text = textsys.write("Special menu music: " .. am,x,y,"setup",{font = "header"})
				menusys.button.create("am_yes",x + text.w + 32,y + 6,"setup",{_text = "On", _font = "header", w = 48, h = 14})
				menusys.button.create("am_no",x + text.w + 92,y + 6,"setup",{_text = "Off", _font = "header", w = 48, h = 14})
			end
			y = y + 24
			text = textsys.write("Clear save data:",x,y,"setup",{font = "header"})
			menusys.button.create("clear",x + text.w + 32,y + 6,"setupclear",{_text = "Clear", _font = "header", w = 48, h = 14})
		end,
		
		button_closesetup = function(unit,mousebutton,key)
			if (mousebutton == 1) then
				delay = 5
				menusys.button.erase()
				textsys.erase()
				unitsys.reset()
				
				local w,h,f = love.window.getMode()
				local setup = filesys.ini.open("settings.txt")
				setup:write("settings","scaling",scaling)
				setup:writebool("settings","integral",integral)
				setup:write("settings","fint",tostring(fscreen_int))
				setup:writebool("settings","fullscreen",f.fullscreen)
				
				local musvol = VOLUMES.music * 100
				local sfxvol = VOLUMES.sfx * 100
				setup:write("settings","music",musvol)
				setup:write("settings","sound",sfxvol)
				
				setup:write("settings","undo",tostring(undomode))
				setup:write("settings","rom",tostring(numeralmode))
				setup:write("settings","prompt",tostring(promptmode))
				setup:write("settings","streakmode",tostring(streakmode))
				setup:write("settings","focus",tostring(AUDIOFOCUSMODE))
				setup:write("settings","high",tostring(highmode))
				setup:write("settings","spr",tostring(spreadmode))
				
				local cb = 0
				if colourblindmode then
					cb = 1
				end
				setup:write("settings","cb",tostring(cb))
				setup:write("settings","alternate",tostring(alternatemusic))
				
				local seeding = 0
				local seed = RANDOMSEED.seed
				if RANDOMSEED.seeding then
					seeding = 1
				end
				setup:write("settings","seeding",seeding)
				setup:write("settings","seed",tostring(seed))
				setup:store()
				
				audiosys.play("error2")
				menusys.change("main")
			end
		end,
		
		button_seed = function(unit,mousebutton,key)
			local w,h,f = love.window.getMode()
			
			if (mousebutton == 1) then
				RANDOMSEED.seeding = true
				menusys.refresh()
				
				audiosys.play("beep3")
			end
		end,
		
		button_noseed = function(unit,mousebutton,key)
			local w,h,f = love.window.getMode()
			
			if (mousebutton == 1) then
				RANDOMSEED.seeding = false
				menusys.refresh()
				
				audiosys.play("beep3")
			end
		end,
		
		button_copyseed = function(unit,mousebutton,key)
			local w,h,f = love.window.getMode()
			
			if (mousebutton == 1) then
				love.system.setClipboardText(tostring(RANDOMSEED.seed))
				
				audiosys.play("beep3")
			end
		end,
		
		button_pasteseed = function(unit,mousebutton,key)
			local w,h,f = love.window.getMode()
			
			if (mousebutton == 1) then
				local seed = tonumber(love.system.getClipboardText()) or 0
				gamesys.setseed(seed,true)
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_x1 = function(unit,mousebutton,key)
			local w,h,f = love.window.getMode()
			
			if (mousebutton == 1) and (scaling ~= 1) and (f.fullscreen == false) then
				delay = 5
				scaling = 1.0
				love.window.setMode(screenw * scaling, screenh * scaling)
				
				gamesys.centerwindow()
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_x2 = function(unit,mousebutton,key)
			local w,h,f = love.window.getMode()
			
			if (mousebutton == 1) and (scaling ~= 2) and (f.fullscreen == false) then
				delay = 5
				scaling = 2.0
				love.window.setMode(screenw * scaling, screenh * scaling)
				
				gamesys.centerwindow()
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_x3 = function(unit,mousebutton,key)
			local w,h,f = love.window.getMode()
			
			if (mousebutton == 1) and (scaling ~= 3) and (f.fullscreen == false) then
				delay = 5
				scaling = 3.0
				love.window.setMode(screenw * scaling, screenh * scaling)
				
				gamesys.centerwindow()
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_fscreen_on = function(unit,mousebutton,key)
			local w,h,f = love.window.getMode()
			
			if (mousebutton == 1) and (f.fullscreen == false) then
				delay = 5
				updatefullscreen()
				
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_fscreen_off = function(unit,mousebutton,key)
			local w,h,f = love.window.getMode()
			
			if (mousebutton == 1) and f.fullscreen then
				delay = 5
				local f = {}
				f.fullscreen = false
				love.window.setMode(0, 0, f)
				scaling = 2.0
				screenw = GAME.width
				screenh = GAME.height
				love.window.setMode(screenw * scaling, screenh * scaling)
				margin = 0
				marginy = 0
				
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_int_on = function(unit,mousebutton,key)
			if (mousebutton == 1) and (integral == false) then
				delay = 5
				integral = true
				local filter = "nearest"
				local linestyle = "rough"
				
				love.graphics.setDefaultFilter(filter)
				
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_int_off = function(unit,mousebutton,key)
			if (mousebutton == 1) and integral then
				delay = 5
				integral = false
				local filter = "linear"
				local linestyle = "smooth"
				
				love.graphics.setDefaultFilter(filter)
				
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_fint_on = function(unit,mousebutton,key)
			if (mousebutton == 1) and (fscreen_int == 1) then
				delay = 5
				fscreen_int = 0
				
				local w,h,f = love.window.getMode()
				if f.fullscreen then
					updatefullscreen()
				end
				
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_fint_off = function(unit,mousebutton,key)
			if (mousebutton == 1) and (fscreen_int == 0) then
				delay = 5
				fscreen_int = 1
				
				local w,h,f = love.window.getMode()
				if f.fullscreen then
					updatefullscreen()
				end
				
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_undo_no = function(unit,mousebutton,key)
			if (mousebutton == 1) and (undomode ~= 2) then
				delay = 5
				undomode = 2
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_undo_one = function(unit,mousebutton,key)
			if (mousebutton == 1) and (undomode ~= 1) then
				delay = 5
				undomode = 1
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_undo_yes = function(unit,mousebutton,key)
			if (mousebutton == 1) and (undomode ~= 0) then
				delay = 5
				undomode = 0
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_rom_no = function(unit,mousebutton,key)
			if (mousebutton == 1) and (numeralmode ~= 1) then
				delay = 5
				numeralmode = 1
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_rom_yes = function(unit,mousebutton,key)
			if (mousebutton == 1) and (numeralmode ~= 0) then
				delay = 5
				numeralmode = 0
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_high_no = function(unit,mousebutton,key)
			if (mousebutton == 1) and (highmode ~= 1) then
				delay = 5
				highmode = 1
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_high_yes = function(unit,mousebutton,key)
			if (mousebutton == 1) and (highmode ~= 0) then
				delay = 5
				highmode = 0
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_spr_no = function(unit,mousebutton,key)
			if (mousebutton == 1) and (spreadmode ~= 0) then
				delay = 5
				spreadmode = 0
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_spr_yes = function(unit,mousebutton,key)
			if (mousebutton == 1) and (spreadmode ~= 1) then
				delay = 5
				spreadmode = 1
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_focus_no = function(unit,mousebutton,key)
			if (mousebutton == 1) and (AUDIOFOCUSMODE ~= 0) then
				delay = 5
				AUDIOFOCUSMODE = 0
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_focus_yes = function(unit,mousebutton,key)
			if (mousebutton == 1) and (AUDIOFOCUSMODE ~= 1) then
				delay = 5
				AUDIOFOCUSMODE = 1
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_prompt_no = function(unit,mousebutton,key)
			if (mousebutton == 1) and (promptmode ~= 0) then
				delay = 5
				promptmode = 0
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_prompt_yes = function(unit,mousebutton,key)
			if (mousebutton == 1) and (promptmode ~= 1) then
				delay = 5
				promptmode = 1
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_cb_no = function(unit,mousebutton,key)
			if (mousebutton == 1) and (colourblindmode == true) then
				delay = 5
				colourblindmode = false
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_cb_yes = function(unit,mousebutton,key)
			if (mousebutton == 1) and (colourblindmode == false) then
				delay = 5
				colourblindmode = true
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_streak_no = function(unit,mousebutton,key)
			if (mousebutton == 1) and (streakmode ~= 1) then
				delay = 5
				streakmode = 1
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_streak_yes = function(unit,mousebutton,key)
			if (mousebutton == 1) and (streakmode ~= 0) then
				delay = 5
				streakmode = 0
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
		
		button_am_no = function(unit,mousebutton,key)
			if (mousebutton == 1) and (alternatemusic == 1) then
				delay = 5
				alternatemusic = 2
				menusys.refresh()
				audiosys.play("beep3")
				audiosys.addevent("music_select","changetrack")
			end
		end,
		
		button_am_yes = function(unit,mousebutton,key)
			if (mousebutton == 1) and (alternatemusic == 2) then
				delay = 5
				alternatemusic = 1
				menusys.refresh()
				audiosys.play("beep3")
				audiosys.addevent(ALTERNATEMUSIC,"changetrack")
			end
		end,
		
		slider_held_music = function(b)
			audiosys.volume("music", b.slider_value * 0.01, true)
		end,
		
		slider_held_sound = function(b)
			audiosys.volume("sfx", b.slider_value * 0.01, true)
		end,
		
		button_clear = function(unit,mousebutton,key)
			if (mousebutton == 1) then
				delay = 5
				local x = unit.x
				local y = unit.y
				menusys.button.erase("setupclear")
				menusys.button.create("clearconfirm",x + 56,y,"setupclear",{_text = "Confirm", _font = "header", w = 48, h = 14, colour = 0xd2635b})
				menusys.button.create("clearcancel",x,y,"setupclear",{_text = "Cancel", _font = "header", w = 48, h = 14})
				audiosys.play("beep3")
			end
		end,
		
		button_clearconfirm = function(unit,mousebutton,key)
			if (mousebutton == 1) then
				delay = 5
				local save = filesys.ini.open("save.txt")
				save:erase()
				save:store()
				menusys.refresh()
				audiosys.play("defeat")
			end
		end,
		
		button_clearcancel = function(unit,mousebutton,key)
			if (mousebutton == 1) then
				delay = 5
				menusys.refresh()
				audiosys.play("beep3")
			end
		end,
	},
	
	restartprompt =
	{
		enter = function()
			menusys.button.disable("ui")
			ORDER[3] = {}
			local o = ORDER[3]
			local c = getrgb(BACKCOL,0.45,0.9)
			o.effect = function() love.graphics.setColor(c) love.graphics.rectangle("fill", 0, math.floor((screenh * 0.5 - 48)) * scaling, screenw * scaling, 96 * scaling) love.graphics.setColor(1, 1, 1, 1) end
			textsys.write("Are you sure you want to restart?",screenw * 0.5,screenh * 0.5 - 20,"restartprompt",{font = "header", xoffset = -0.5, yoffset = -0.5, layer = 3})
			menusys.button.create("back",screenw * 0.5 + 56,screenh * 0.5 + 16,"restartprompt",{_text = "Cancel", w = 96, h = 24, layer = 3})
			menusys.button.create("confirm",screenw * 0.5 - 56,screenh * 0.5 + 16,"restartprompt",{_text = "Restart", w = 96, h = 24, layer = 3})
		end,
		
		button_back = function()
			menusys.button.erase("restartprompt")
			textsys.erase("restartprompt")
			unitsys.remove_byclass("restartprompt")
			menusys.button.enable("ui",true)
			ORDER[3] = nil
			menusys.close()
			
			audiosys.play("error2")
		end,
		
		button_confirm = function()
			menusys.button.erase("restartprompt")
			textsys.erase("restartprompt")
			unitsys.remove_byclass("restartprompt")
			menusys.button.enable("ui",true)
			ORDER[3] = nil
			menusys.close()
			
			inputsys.input("r",false)
		end,
	},
	
	quitprompt =
	{
		enter = function()
			menusys.button.disable("ui")
			ORDER[3] = {}
			local o = ORDER[3]
			local c = getrgb(BACKCOL,0.45,0.9)
			o.effect = function() love.graphics.setColor(c) love.graphics.rectangle("fill", 0, math.floor((screenh * 0.5 - 48)) * scaling, screenw * scaling, 96 * scaling) love.graphics.setColor(1, 1, 1, 1) end
			textsys.write("Are you sure you want to exit?",screenw * 0.5,screenh * 0.5 - 20,"restartprompt",{font = "header", xoffset = -0.5, yoffset = -0.5, layer = 3})
			menusys.button.create("back",screenw * 0.5 + 56,screenh * 0.5 + 16,"restartprompt",{_text = "Cancel", w = 96, h = 24, layer = 3})
			menusys.button.create("confirm",screenw * 0.5 - 56,screenh * 0.5 + 16,"restartprompt",{_text = "Exit", w = 96, h = 24, layer = 3})
		end,
		
		button_back = function()
			menusys.button.erase("restartprompt")
			textsys.erase("restartprompt")
			unitsys.remove_byclass("restartprompt")
			menusys.button.enable("ui",true)
			ORDER[3] = nil
			menusys.close()
			
			audiosys.play("error2")
		end,
		
		button_confirm = function()
			menusys.button.erase("restartprompt")
			textsys.erase("restartprompt")
			unitsys.remove_byclass("restartprompt")
			menusys.button.enable("ui",true)
			ORDER[3] = nil
			menusys.close()
			
			inputsys.input("escape",false)
		end,
	},
	
	music =
	{
		enter = function()
			menusys.button.disable("ui")
			ORDER[3] = {}
			local o = ORDER[3]
			local c = getrgb(BACKCOL,0.45,0.9)
			o.effect = function() love.graphics.setColor(c) love.graphics.rectangle("fill", 0, 0, screenw * scaling, screenh * scaling) love.graphics.setColor(1, 1, 1, 1) end
			
			local gdata = subgames[game]
			
			local y = marginy + 32
			textsys.write("Switch music:",screenw * 0.5,marginy + 32,"music",{font = "header", xoffset = -0.5, yoffset = -0.5, layer = 3})
			local mus = {}
			for i,v in pairs(AUDIOLIST) do
				if (v.type == "music") and (i ~= "music_mystery") then
					table.insert(mus, {i, v.title})
				end
			end
			table.insert(mus, {"random", "Random track"})
			
			local musfunc = function(b) local music = b.name if ((AUDIOLIST[music] ~= nil) or (music == "random")) and (delay == 0) then local m = getmusic(music) audiosys.addevent(m,"changetrack") local setup = filesys.ini.open("settings.txt") setup:write("music",game,music) setup:store() gamemusic = music menusys.change("music") delay = 5 end end
			
			y = y + 18
			for i,v in ipairs(mus) do
				local b = menusys.button.create(v[1],screenw * 0.5,y,"music",{_text = v[2], w = 128, h = 16, layer = 3})
				b.func = musfunc
				
				if (gamemusic == v[1]) then
					textsys.write("Current",screenw * 0.5 - 72,y,"music",{font = "header", xoffset = -1.0, yoffset = -0.5, layer = 3})
				end
				
				if (gdata.music ~= nil) and (v[1] == gdata.music) then
					textsys.write("Default",screenw * 0.5 + 72,y,"music",{font = "header", yoffset = -0.5, layer = 3})
				end
				
				y = y + 18
			end
			y = y + 6
			menusys.button.create("back",screenw * 0.5,y,"music",{_text = "Return", w = 96, h = 16, layer = 3})
			
			x = margin
			y = marginy + 4
			local mvol = math.floor(VOLUMES.music * 100)
			text = textsys.write("Music volume:",x + 92,y,"music",{layer = 3, xoffset = -0.5})
			menusys.button.create_slider("music",x + 12,y + 8 + 6,"music",{w = 168, h = 12, slider_value = mvol, _sprite = "slider", layer = 3})
			y = y + 20
			local svol = math.floor(VOLUMES.sfx * 100)
			text = textsys.write("SFX volume:",x + 92,y,"music",{layer = 3, xoffset = -0.5})
			menusys.button.create_slider("sound",x + 12,y + 8 + 6,"music",{w = 168, h = 12, slider_value = svol, _sprite = "slider", layer = 3})
		end,
		
		button_back = function()
			menusys.button.erase("music")
			textsys.erase("music")
			unitsys.remove_byclass("music")
			menusys.button.enable("ui",true)
			ORDER[3] = nil
			
			local setup = filesys.ini.open("settings.txt")
			local musvol = VOLUMES.music * 100
			local sfxvol = VOLUMES.sfx * 100
			setup:write("settings","music",musvol)
			setup:write("settings","sound",sfxvol)
			setup:store()
			
			menusys.close()
			
			audiosys.play("error2")
		end,
		
		slider_held_music = function(b)
			audiosys.volume("music", b.slider_value * 0.01, true)
		end,
		
		slider_held_sound = function(b)
			audiosys.volume("sfx", b.slider_value * 0.01, true)
		end,
	},
}