TODO: ENTIRE FILE
MOD_SCRIPTS =
{
	setup = function()
		piles = {}
		inputsys.ignore = true
		
		spritesys.change("card",murder_sprites.card)
		spritesys.add("overlay","gfx/deck_murder_overlay",murder_sprites.overlay)
		spritesys.add("column","gfx/murder_column",murder_sprites.column)
		spritesys.add("marker","gfx/murder_marker",murder_sprites.marker)
		menusys.button.erase(nil,"ready")
		
		local origin = margin + 32
		local y = marginy + 64
		local slotdata = {card_offsets = {0,12}, check_pick = scripts.pile_check_pick, check_place = scripts.pile_check_place_hold, _anim = "pile_white"}
		piles.hold1 = unitsys.create("pile","hold1",origin + 64 * 1,y,slotdata)
		piles.hold2 = unitsys.create("pile","hold2",origin + 64 * 2,y,slotdata)
		piles.hold3 = unitsys.create("pile","hold3",origin + 64 * 3,y,slotdata)
		piles.hold4 = unitsys.create("pile","hold4",origin + 64 * 4,y,slotdata)
		
		slotdata = {card_offsets = {0,12}, check_pick = scripts.pile_check_pick, check_place = scripts.pile_check_place, _anim = "pile_white"}
		piles.hand = unitsys.create("pile","hand",0,0,{open = false, card_offsets = {0,12}, _visible = false, hold_offsets = {0,0}, lerp = 1.0})
		piles.deck = unitsys.create("pile","deck",origin + 64 * 5,y + 88,{open = false, card_offsets = {0,-0.5}, _visible = false})
		piles.slot1 = unitsys.create("pile","slot1",origin + 64 * 0,y + 88,slotdata)
		piles.slot2 = unitsys.create("pile","slot2",origin + 64 * 1,y + 88,slotdata)
		piles.slot3 = unitsys.create("pile","slot3",origin + 64 * 2,y + 88,slotdata)
		piles.slot4 = unitsys.create("pile","slot4",origin + 64 * 3,y + 88,slotdata)
		piles.slot5 = unitsys.create("pile","slot5",origin + 64 * 4,y + 88,slotdata)
		
		piles.slot6 = unitsys.create("pile","slot6",origin + 64 * 6 + 6,marginy + 64,{open = false, card_offsets = {0,0}, _anim = "pile_white"})
		local cards = {"a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a11","a12","a13","b1","b2","b3","b4","b5","b6","b7","b8","b9","b10","b11","b12","b13","c1","c2","c3","c4","c5","c6","c7","c8","c9","c10","c11","c12","c13","d1","d2","d3","d4","d5","d6","d7","d8","d9","d10","d11","d12","d13"}
		local suits = {a = 1, b = 2, c = 3, d = 4}
		
		local titles = {
		"a knife","a gun","a pitchfork","poison","an axe","guillotine","a car crash","a baseball bat",
		"an intercontinental missile","a grand piano","a fire","a fatal fall","a metal pipe","a cursed heirloom","a throwing star","autocombustion",
		"fleeing to exile","a dark past","a luxury yacht","heartbreak","depressing thoughts","a long illness","a scandal","blackmail",
		"defenestration","disgrace","death","doubt","drowning","nightmares","secret affair","an old grudge",
		}
		local titlenums = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"}
		
		local char_a = {"Lord","Lady","Miss","Mrs","Sir","Comtessa","Baron","Prince","Judge","Dr","Mr","The","Princess","King","Queen","His Majesty","Her Majesty","Baroness","Their Majesty","Duke","Dukess","Master","Mistress","Archjudge","","","","",""}
		local char_b = {"De","Von","San","Of","Af","Auf","Oeuf","Da","Del","Le","Las","Los","","","","","","","","","","","","","","","","","","","","","Van"}
		local char_c = {"Blue","Green","Yellow","Brown","Orange","Purple","Grey","Sauer","Kreuz","Wald","Rose","Dark","Bright","Gold","Silver","Copper","Steel","Iron","Hump","Snort","Snark","Stark","Stork","Lark","Moss","Gleam","Gloom","Dusk","Dust","Crack","Ample","Large","Huge","Small","Spade","Heart","Club","Diamond","Dirk","Sword","Knight","Drink","Drunk","Strong","Weak","Plaster","Baba","Keke","Jingle","Wit","Dumpling","Bristle","Ice","Frost","Fire","Storm","Broke","Rich","Fancy","Grudge","Cash","Treasure","Bromp","Blerp","Blomp","Glarp","Blurp","Blop","Blerb","Grub","Gulp","Leaf","Unicorn","Horse","Hound","Cat","Lion","Giraffe","Porpoise","Lost","Dank","Slick","English","Fried","Leg"}
		local char_d = {"hound","horse","moon","ton","bottom","back","bunch","thump","dink","dank","donk","bank","brook","forest","cove","haven","hovel","castle","town","s","book","drink","mountain","hill","lake","sea","sand","bag","chain","chunk","sun","less","don","ins","in","end","-end","-back","hearth","beard","hair","mouth","clock","lamp","blimp","face","fist","foot","arm","hand","deck","card","cast","tome","land","hum","mud","sludge","slime","slag","slick","theremin","glockenspiel","triangle","square","circle","sphere","quad","plane","spot","boat","ship","shipper","","","","","son","daughter","child","dook","fry","rich","inthearm","-on-rye","-on-ham","-on-egg","lad","lass","chimney","ling","y"}
		
		local methods = {"stabbed with","crushed under","poisoned with","shot with","bludgeoned with","hit with","killed with","electrocuted with","impaled with","scared to death with","burned with","drowned with","succumbed to"}
		local mrng = gamesys.random(1, #methods)
		vars.method = methods[mrng]
		
		local pilecounts = {0, 0, 0, 0}
		pilecounts[1] = gamesys.random(4, 15)
		pilecounts[2] = gamesys.random(4, 15)
		pilecounts[3] = gamesys.random(4, 15)
		pilecounts[4] = #cards - 3 - pilecounts[1] - pilecounts[2] - pilecounts[3]
		
		local killers = {"a1","a10","a11","a12","a13","b1","b10","b11","b12","b13","c1","c10","c11","c12","c13","d1","d10","d11","d12","d13"}
		local weapons = {"a2","a3","a4","a5","a6","a7","a8","a9","b2","b3","b4","b5","b6","b7","b8","b9","c2","c3","c4","c5","c6","c7","c8","c9","d2","d3","d4","d5","d6","d7","d8","d9"}
		local hints = {"no","ki7","ki1","ki2","ki3","ki4","ki5","we6","kil","kil","no","we7","we1","we2","we3","we4","we5","wel","wel"}
		
		local hint_no = {"- Who? I know nothing.", "- Sorry, I can't help you.", "- I don't know.", "- I didn't see the murder.", "- What?", "- I've no idea."}
		
		local killer = gamesys.random(1, #killers)
		local weapon = gamesys.random(1, #weapons)
		vars.killer = killers[killer]
		vars.weapon = weapons[weapon]
		
		for i=1,#cards do
			local opt = gamesys.random(1, #cards)
			local name = cards[opt]
			local s = suits[string.sub(name, 1, 1)]
			local v = tonumber(string.sub(name, 2))
			local slotnum = gamesys.random(0, 3)
			local slot = "slot" .. tostring(slotnum + 1)
			
			local title = "ERROR"
			local titleanim = "none"
			local character = false
			
			if (v == 1) or (v >= 10) then
				local rnd1 = gamesys.random(1, #char_a)
				local rnd2 = gamesys.random(1, #char_b)
				local rnd3 = gamesys.random(1, #char_c)
				local rnd4 = gamesys.random(1, #char_d)
				title = ""
				
				if (#char_a[rnd1] > 0) then
					title = char_a[rnd1] .. " "
				end
				
				if (#char_b[rnd2] > 0) then
					title = title .. char_b[rnd2] .. " "
				end
				
				title = title .. char_c[rnd3] .. char_d[rnd4]
				character = true
			elseif (#titles > 0) then
				local titlernd = gamesys.random(1, #titles)
				title = titles[titlernd]
				titleanim = titlenums[titlernd]
				
				table.remove(titles, titlernd)
				table.remove(titlenums, titlernd)
			end
			
			local card = unitsys.create("card",name,piles.deck.x,piles.deck.y,{value = v, suit = s, title = title, titleanim = titleanim, hint = "", hint_true = true, hint_no = false, _sprites = {"overlay","column","column","column","column"}, guess = 1, column = 2})
			card.sprites[3].xoffset = -6
			card.sprites[4].xoffset = -12
			card.sprites[5].xoffset = -18
			-- card.sprite.visible = false
			
			if (card.name == vars.killer) then
				vars.killer_title = card.title
			end
			
			if (card.name == vars.weapon) then
				vars.weapon_title = card.title
			end
			
			if (#piles.slot6.cards == 0) and character and (card.name ~= vars.killer) then
				card.pile = "slot6"
				table.insert(piles.slot6.cards, card)
				card.pileid = #piles.slot6.cards
				textsys.write("Who killed " .. card.title .. " and with what?",screenw - margin - 112,marginy + 8,"victim",{font = "header", xoffset = -1.0})
				textsys.write("Witness accounts:",screenw - margin - 112,screenh * 0.5 - 80,"hint",{font = "header", xoffset = -0.5})
				spritesys.anim.set(card.sprite,card.name)
				
				vars.victim = card.name
				vars.victim_title = card.title
			else
				if character then
					spritesys.anim.set(card.sprite, "back2")
				end
				
				while (pilecounts[slotnum + 1] == 0) and (slotnum < 3) do
					slotnum = (slotnum + 1) % 4
				end
				
				if (pilecounts[slotnum + 1] > 0) or (slotnum == 3) then
					card.pile = slot
					table.insert(piles[slot].cards, card)
					card.pileid = #piles[slot].cards
					pilecounts[slotnum + 1] = pilecounts[slotnum + 1] - 1
				end
			end
			
			table.remove(cards, opt)
		end
		
		local cs = unitsys.findall("card")
		local lielist = {"1", "2", "3", "4", "5", "6", "7"}
		for i,card in ipairs(cs) do
			if ((card.value == 1) or (card.value >= 10)) and (card.name ~= vars.victim) then
				local rnd = gamesys.random(1, #hints)
				local hint = hints[rnd]
				
				if (hint == "no") then
					local rnd2 = gamesys.random(1, #hint_no)
					card.hint = hint_no[rnd2]
					card.hint_no = true
				else
					local target = ""
					local hintid = ""
					local hint_text = ""
					local target_name = ""
					if (string.sub(hint, 1, 2) == "ki") then
						target = vars.killer
						target_name = "killer"
					elseif (string.sub(hint, 1, 2) == "we") then
						target = vars.weapon
						target_name = "weapon"
					end
					
					local hv = tonumber(string.sub(target, 2)) or 0
					local hs = string.sub(target, 1, 1)
					local suitnames = {a = "Clubs", b = "Spades", c = "Hearts", d = "Diamonds"}
					local suitids = {"a", "b", "c", "d"}
					
					local hintid = string.sub(hint, 3)
					local corrects = string.sub(target, 1, 1)
					local correctv = tonumber(string.sub(target, 2))
					
					if (hintid == "l") then
						local lrnd = gamesys.random(1, #lielist)
						hintid = lielist[lrnd]
						table.remove(lielist, lrnd)
						
						hs = suitids[gamesys.random(1,4)]
						hv = gamesys.random(1,13)
						target = hs .. tostring(hv)
						
						card.hint_true = false
					end
					
					if (hintid == "1") then
						if (card.hint_true == false) then
							while (hs == corrects) do
								hs = suitids[gamesys.random(1,4)]
							end
						end
						
						hint_text = "- The " .. target_name .. "'s suit is " .. suitnames[hs] .. "."
					elseif (hintid == "2") then
						if (card.hint_true == false) then
							hv = correctv + 1
						end
						
						if (hv % 2 == 0) then
							hint_text = "- The " .. target_name .. "'s value is even."
						else
							hint_text = "- The " .. target_name .. "'s value is odd."
						end
					elseif (hintid == "3") then
						if (card.hint_true == false) then
							if (correctv == 2) or (correctv == 3) or (correctv == 5) or (correctv == 7) or (correctv == 11) or (correctv == 13) then
								hv = 4
							else
								hv = 3
							end
						end
						
						if (hv == 2) or (hv == 3) or (hv == 5) or (hv == 7) or (hv == 11) or (hv == 13) then
							hint_text = "- The " .. target_name .. "'s value is a prime number."
						else
							hint_text = "- The " .. target_name .. "'s value is not a prime number."
						end
					elseif (hintid == "4") then
						if (card.hint_true == false) then
							while (hv == correctv) do
								hv = gamesys.random(1,13)
							end
						end
						
						local news = gamesys.random(1, 4)
						local newname = suitids[news] .. tostring(hv)
						local names = {"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"}
						
						local card2 = unitsys.find("card",newname)
						hint_text = "- The " .. target_name .. " shares value with '" .. textsys.capitalize(card2.title) .. "'."
					elseif (hintid == "5") then
						if (card.hint_true == false) then
							while (hs == corrects) do
								hs = suitids[gamesys.random(1,4)]
							end
						end
						
						local newv = gamesys.random(1, 13)
						local newname = hs .. tostring(newv)
						local names = {a = "C", b = "S", c = "H", d = "D"}
						
						local card2 = unitsys.find("card",newname)
						hint_text = "- The " .. target_name .. " shares suit with '" .. textsys.capitalize(card2.title) .. "'."
					elseif (hintid == "6") then
						local dividers = {3, 4}
						local rnd2 = gamesys.random(1, #dividers)
						local divider = dividers[rnd2]
						
						if (card.hint_true == false) then
							while (hv % divider == correctv % divider) do
								hv = gamesys.random(1,13)
							end
						end
						
						if (hv % divider == 0) then
							hint_text = "- The " .. target_name .. "'s value is divisible by " .. tostring(divider) .. "."
						else
							hint_text = "- The " .. target_name .. "'s value is not divisible by " .. tostring(divider) .. "."
						end
					elseif (hintid == "7") then
						hint_text = target_name
					end
					
					card.hint = hint_text
				end
				
				table.remove(hints, rnd)
			end
		end
		
		alert(vars.killer, 9000)
		alert(vars.weapon, 9000)
		
		menusys.button.create("ready",screenw - margin - 40,marginy + 80,"ui",{_text = "I know!", w = 64, h = 24})
		scripts.drawhints()
	end,
	
	cleanup = function()
		textsys.erase("victim")
		textsys.erase("title")
		textsys.erase("hint")
		spritesys.delete("overlay")
		spritesys.delete("marker")
		spritesys.delete("column")
		unitsys.reset()
	end,
	
	info = function(l)
		local text =
		{
		"- Your task is to figure out $Ca7d962who$CW killed " .. vars.victim_title .. " at the party and with $Ca7d962what$CW. Both the $Ca7d962killer$CW and the $Ca7d962weapon$CW are cards in the deck.",
		"- Each $Ce3c18810$CW and $Ce3c188face card$CW is a $C74c0e6party guest$CW (for a total of $Ce3c18819 guests$CW, discounting the victim), and every other card is a potential $Ca7d962murder weapon$CW or method. Hover over each card to see its name.",
		"- Each time a $C74c0e6guest$CW is revealed, they're questioned and their response appears on the $Ceb8ederight edge of the screen$CW. However, $Ce3c1882 guests$CW have $Cd98079no idea$CW what happened, and $Ce3c1884 other guests$CW give an $Cd98079incorrect account$CW of the events, 2 about the $Ca7d962murder weapon$CW and 2 about the $Ca7d962killer$CW.",
		"- Some responses claim that the killer or murder weapon is in a particular stack; in such cases all cards in that stack get marked with a number indicating which response relates to them.",
		"- You can use the $Ceb8ede4 buttons$CW next to every response to keep track of whether you think they're $Ca7d962true$CW or $Cd98079false$CW.",
		"- Once you think you know the identities of the $Ca7d962killer$CW and the $Ca7d962weapon$CW used in the deed, press the $Ce3c188'I Know!'$CW button.",
		"- You can place cards on each other as long as their $Ce3c188values differ by exactly 1$CW, no matter what their suits.",
		"- You can pick up a stack of any size as long as all the cards are in $Ce3c188descending$CW order. $C8bc8e7Aces$CW are counted as $C8bc8e71$CW in all situations.",
		"- At the top of the screen are $Ceb8ede4 slots$CW that can hold $C8bc8e71 card$CW each.",
		}
		
		textsys.write(text,16,32,"info",{layer = l, font = "header", gap = 5, wrap = screenw - 32})
	end,
	
	gameflow = function()
		if (delay == 0) then
			if (vars.mode == 0) then
				inputsys.ignore = false
				
				piles.slot1.card_offsets[2] = dynamicoffset(piles.slot1,14,2)
				piles.slot2.card_offsets[2] = dynamicoffset(piles.slot2,14,2)
				piles.slot3.card_offsets[2] = dynamicoffset(piles.slot3,14,2)
				piles.slot4.card_offsets[2] = dynamicoffset(piles.slot4,14,2)
				piles.slot5.card_offsets[2] = dynamicoffset(piles.slot5,14,2)
				
				if (#piles.hand.cards == 0) then
					for i=1,4 do
						local slot = "slot" .. tostring(i)
						local pile = piles[slot]
						
						if (#pile.cards > 0) then
							local c = pile.cards[#pile.cards]
							
							if (c.sprite.anim == "back") or (c.sprite.anim == "back2") then
								if (c.sprite.anim == "back2") then
									addundo({"hint"})
									table.insert(vars.hints, c)
									scripts.drawhints()
									
									if (c.hint_no == false) then
										vars.guests = vars.guests + 1
										alert(vars.guests)
									end
								end
								
								addundo({"anim",c.sprite,c.sprite.anim})
								addundo({"anim",c.sprites[1],c.sprites[1].anim})
								spritesys.anim.set(c.sprite,c.name)
								spritesys.anim.set(c.sprites[1],c.titleanim)
								-- vars.turnsleft = vars.turnsleft - 1
							end
						end
					end
					
					scripts.showtitle()
				end
				
				local m_ = unitsys.findall("marker")
				for i,v in ipairs(m_) do
					if (string.sub(v.name, 1, 5) ~= "title") then
						if (v.chosen == 1) then
							spritesys.anim.set(v.sprite,"chosen")
						else
							spritesys.anim.set(v.sprite,"none")
						end
					end
				end
				
				local m = inputsys.gethover("marker")
				for i,v in ipairs(m) do
					if (string.sub(v.name, 1, 5) ~= "title") then
						spritesys.anim.set(v.sprite,"hover")
						break
					end
				end
				
				--[[
				textsys.erase("turns")
				textsys.write(tostring(vars.turnsleft),screenw - 8,screenh - 72,"turns",{font = "numbers", xoffset = -1.0})
				textsys.write("minutes until culprit escapes",screenw - 8,screenh - 24,"turns",{font = "header", xoffset = -1.0})
				]]--
			else
				local u = inputsys.gethover("cardbutton",2)
				if (u[1] ~= nil) then
					scripts.showtitle(u[1],2)
				end
			end
		end
	end,
	
	drawhints = function()
		textsys.erase("hint")
		unitsys.remove_byclass("marker")
		
		unitsys.create("marker","title1",screenw - margin - 8 - 48 + 8,screenh * 0.5 - 64 - 12 + 4,{_anim = "yes"})
		unitsys.create("marker","title2",screenw - margin - 8 - 36 + 8,screenh * 0.5 - 64 - 12 + 4,{_anim = "maybe"})
		unitsys.create("marker","title3",screenw - margin - 8 - 12 + 8,screenh * 0.5 - 64 - 12 + 4,{_anim = "no"})
		unitsys.create("marker","title3",screenw - margin - 8 - 24 + 8,screenh * 0.5 - 64 - 12 + 4,{_anim = "unsure"})
		for i,c in ipairs(vars.hints) do
			if (string.sub(c.hint, 1, 1) == "-") then
				addundo({"murderhint",c.id,c.hint})
				c.hint = tostring(i) .. ". " .. string.sub(c.hint, 3)
			end
			
			local hint = c.hint
			if c.hint_no then
				hint = "$Cc56f68" .. hint
			end
			
			if (hint == "killer") or (hint == "weapon") then
				local tcard = unitsys.find("card",vars[hint])
				local pileid = tonumber(string.sub(tcard.pile, -1))
				local ord = {"the first slot", "the second slot", "the third slot", "the fourth slot", "the fifth slot", "a holding slot"}
				
				if (string.sub(tcard.pile, 1, 4) == "hold") then
					pileid = 6
				end
				
				if (c.hint_true == false) then
					local newpid = gamesys.random(1, #ord)
					while (newpid == pileid) do
						newpid = gamesys.random(1, #ord)
					end
					pileid = newpid
				end
				
				local pile = "slot" .. tostring(pileid)
				if (pileid ~= 6) then
					local p = piles[pile]
					for a,b in ipairs(p.cards) do
						local ts = b.column
						if (ts < 5) then
							addundo({"anim",b.sprites[ts],b.sprites[ts].anim})
							addundo({"murdercolumn",b.id,b.column})
							spritesys.anim.set(b.sprites[ts],i)
							b.column = b.column + 1
						end
					end
				else
					if (#piles.hold1.cards > 0) then
						local ts = piles.hold1.cards[1].column
						
						if (ts < 5) then
							addundo({"anim",piles.hold1.cards[1].sprites[ts],piles.hold1.cards[1].sprites[ts].anim})
							addundo({"murdercolumn",piles.hold1.cards[1].id,piles.hold1.cards[1].column})
							spritesys.anim.set(piles.hold1.cards[1].sprites[ts],i)
							piles.hold1.cards[1].column = piles.hold1.cards[1].column + 1
						end
					end
					if (#piles.hold2.cards > 0) then
						local ts = piles.hold2.cards[1].column
						
						if (ts < 5) then
							addundo({"anim",piles.hold2.cards[1].sprites[ts],piles.hold2.cards[1].sprites[ts].anim})
							addundo({"murdercolumn",piles.hold2.cards[1].id,piles.hold2.cards[1].column})
							spritesys.anim.set(piles.hold2.cards[1].sprites[ts],i)
							piles.hold2.cards[1].column = piles.hold2.cards[1].column + 1
						end
					end
					if (#piles.hold3.cards > 0) then
						local ts = piles.hold3.cards[1].column
						
						if (ts < 5) then
							addundo({"anim",piles.hold3.cards[1].sprites[ts],piles.hold3.cards[1].sprites[ts].anim})
							addundo({"murdercolumn",piles.hold3.cards[1].id,piles.hold3.cards[1].column})
							spritesys.anim.set(piles.hold3.cards[1].sprites[ts],i)
							piles.hold3.cards[1].column = piles.hold3.cards[1].column + 1
						end
					end
					if (#piles.hold4.cards > 0) then
						local ts = piles.hold4.cards[1].column
						
						if (ts < 5) then
							addundo({"anim",piles.hold4.cards[1].sprites[ts],piles.hold4.cards[1].sprites[ts].anim})
							addundo({"murdercolumn",piles.hold4.cards[1].id,piles.hold4.cards[1].column})
							spritesys.anim.set(piles.hold4.cards[1].sprites[ts],i)
							piles.hold4.cards[1].column = piles.hold4.cards[1].column + 1
						end
					end
				end
				
				addundo({"murderhint",c.id,c.hint})
				local pileword = ord[pileid]
				hint = tostring(i) .. ". The " .. hint .. " is currently in " .. pileword .. "."
				c.hint = hint
			end
			
			if (c.hint_no == false) then
				local guess = c.guess
				local opt1 = unitsys.create("marker","opt1",screenw - margin - 8 - 48 + 8,screenh * 0.5 - 64 + (i-1) * 9 + 4,{_anim = "none", chosen = 0, opt = 0, target = c.id})
				local opt2 = unitsys.create("marker","opt2",screenw - margin - 8 - 36 + 8,screenh * 0.5 - 64 + (i-1) * 9 + 4,{_anim = "none", chosen = 0, opt = 1, target = c.id})
				local opt3 = unitsys.create("marker","opt3",screenw - margin - 8 - 12 + 8,screenh * 0.5 - 64 + (i-1) * 9 + 4,{_anim = "none", chosen = 0, opt = 2, target = c.id})
				local opt4 = unitsys.create("marker","opt4",screenw - margin - 8 - 24 + 8,screenh * 0.5 - 64 + (i-1) * 9 + 4,{_anim = "none", chosen = 0, opt = 3, target = c.id})
				if (guess == 0) then
					spritesys.anim.set(opt1.sprite,"chosen")
					opt1.chosen = 1
					hint = "$Ca7d962" .. hint
				elseif (guess == 1) then
					spritesys.anim.set(opt2.sprite,"chosen")
					opt2.chosen = 1
				elseif (guess == 2) then
					spritesys.anim.set(opt3.sprite,"chosen")
					opt3.chosen = 1
					hint = "$Cc56f68" .. hint
				elseif (guess == 3) then
					spritesys.anim.set(opt4.sprite,"chosen")
					opt4.chosen = 1
					hint = "$Ce3c188" .. hint
				end
			end
			
			-- hint = hint .. " " .. tostring(c.hint_true)
			textsys.write(hint,screenw - margin - 56,screenh * 0.5 - 64 + (i-1) * 9,"hint",{xoffset = -1.0})
		end
	end,
	
	showtitle = function(c,l_)
		textsys.erase("title")
		local card = c or targetcard
		local l = l_ or 1
		if (card ~= nil) then
			if (card.sprite.anim ~= "back") and (card.sprite.anim ~= "back2") then
				local text = textsys.capitalize(card.title)
				textsys.write(text,margin + 8,marginy + 8,"title",{font = "header", layer = l})
			end
		end
	end,
	
	mouse_left = function(key,data)
		if (vars.lost == false) then
			if (vars.mode == 0) then
				if (targetcard ~= nil) and (#piles.hand.cards == 0) and (delay == 0) then
					local unit = targetcard
					local pile = unitsys.find("pile",unit.pile)
					
					if pile.open or pile.open_pick then
						scripts.pick_card(unit)
						delay = 5
					end
				end
				
				if (targetpile ~= nil) and (#piles.hand.cards > 0) and (delay == 0) then
					scripts.place_card()
					delay = 5
				end
				
				if (targetcard == nil) and (targetpile == nil) and (#piles.hand.cards == 0) and (delay == 0) then
					local m = inputsys.gethover("marker")
					for i,v in ipairs(m) do
						if (string.sub(v.name, 1, 5) ~= "title") then
							local c = unitsys.get(v.target)
							c.guess = v.opt
							scripts.drawhints()
							audiosys.play("beep2")
							return
						end
					end
				end
			elseif (vars.mode == 3) and (delay == 0) then
				local u = inputsys.gethover("cardbutton",2)
				if (u[1] ~= nil) then
					delay = 5
					vars.guess_killer = u[1].card
					vars.guess_killer_title = u[1].title
					scripts.ready2()
					
					-- alert(vars.guess_killer)
				end
			elseif (vars.mode == 4) and (delay == 0) then
				local u = inputsys.gethover("cardbutton",2)
				if (u[1] ~= nil) then
					delay = 5
					vars.guess_weapon = u[1].card
					-- alert("TESTING:" .. vars.guess_weapon)
					scripts.ready3()
				end
			end
		end
	end,
	
	mouse_right = function(key,data)
		if (#piles.hand.cards > 0) and (delay == 0) then
			undo(true)
		end
	end,
	
	pick_card = function(unit)
		local pile = unitsys.find("pile",unit.pile)
		local these = {}
		local mx,my = love.mouse.getPosition()
		mx = math.floor(mx / scaling)
		my = math.floor(my / scaling)
		piles.hand.hold_offsets[1] = mx - unit.x
		piles.hand.hold_offsets[2] = my - unit.y
		
		if (pile.check_pick == nil) or pile.check_pick(pile,unit) then
			newundoneeded = true
			
			for i=unit.pileid,#pile.cards do
				local u = pile.cards[i]
				table.insert(these, u)
			end
			
			for i,v in aipairs(these) do
				addundo({"cardtopile",v.id,v.pile})
			end
			
			for i,v in ipairs(these) do
				cardtopile(v,"hand")
			end
			
			audiosys.play("slip_short3")
		end
	end,
	
	place_card = function()
		local pile = piles[targetpile]
		local these = {}
		
		if pile.open or pile.open_place then
			if (pile.check_place == nil) or pile.check_place(pile) then
				local op = false
				
				local card = piles.hand.cards[1]
				if (card.oldpile ~= targetpile) then
					-- vars.turnsleft = vars.turnsleft - 1
				else
					op = true
				end
				
				for i,u in ipairs(piles.hand.cards) do
					table.insert(these, u)
				end
				
				if (op == false) then
					for i,v in aipairs(these) do
						addundo({"cardtopile",v.id,v.pile})
					end
				end
				
				for i,v in ipairs(these) do					
					cardtopile(v,targetpile)
				end
				
				if op then
					removeundo()
				end
				
				audiosys.play("slip_short3")
			end
		end
	end,
	
	pile_check_pick = function(pile,card)
		local s = card.suit+3
		local v = card.value+1
		
		for i=card.pileid,#pile.cards do
			local c = pile.cards[i]
			if (c.sprite.anim == "back") or (c.sprite.anim == "back2") then
				return false
			end
			
			-- if (math.floor((c.suit-1)/2) == math.floor((s-1)/2)) or (c.value ~= v-1) then
			if (c.value ~= v-1) then
				return false
			end
			
			s = c.suit
			v = c.value
		end
		
		return true
	end,
	
	pile_check_place = function(pile)
		local card = piles.hand.cards[1]
		local s = card.suit
		local v = card.value
		local op = card.oldpile
		
		if (#pile.cards > 0) and (op ~= pile.name) then
			local c = pile.cards[#pile.cards]
			
			-- if (math.floor((c.suit-1)/2) == math.floor((s-1)/2)) or (c.value ~= v+1) then
			if (math.abs(c.value - v) ~= 1) then
				return false
			end
		end
		
		return true
	end,
	
	pile_check_place_hold = function(pile)
		local card = piles.hand.cards[1]
		local op = card.oldpile
		
		if (op ~= pile.name) then
			if (#piles.hand.cards > 1) or (#pile.cards > 0) then
				return false
			end
		end
		
		return true
	end,
	
	pile_check_place_end = function(pile)
		local card = piles.hand.cards[1]
		local v = card.value
		
		local suitpilename = "end" .. tostring(card.suit)
		if (pile.name ~= suitpilename) then
			return false
		end
		
		if (#piles.hand.cards > 1) then
			return false
		end
		
		if (#pile.cards > 0) then
			local c = pile.cards[#pile.cards]
			
			if (c.value ~= v-1) or (c.suit ~= card.suit) then
				return false
			end
		elseif (card.value ~= 1) then
			return false
		end
		
		return true
	end,
	
	ready = function()
		if (vars.mode == 0) and (vars.lost == false) then
			menusys.button.disable("ui")
			ORDER[3] = {}
			local o = ORDER[3]
			local c = getrgb(BACKCOL,0.45,0.9)
			o.effect = function() love.graphics.setColor(c) love.graphics.rectangle("fill", 0, math.floor((screenh * 0.5 - 48)) * scaling, screenw * scaling, 96 * scaling) love.graphics.setColor(1, 1, 1, 1) end
			textsys.write("Are you sure? You won't be able to return.",screenw * 0.5,screenh * 0.5 - 20,"guessprompt",{font = "header", xoffset = -0.5, yoffset = -0.5, layer = 3})
			menusys.button.create("combine",screenw * 0.5 - 56,screenh * 0.5 + 16,"guessprompt",{_text = "Yes", w = 96, h = 24, layer = 3})
			menusys.button.create("cancel",screenw * 0.5 + 56,screenh * 0.5 + 16,"guessprompt",{_text = "No", w = 96, h = 24, layer = 3})
		end
	end,
	
	combineslots = function()
		if (vars.mode == 0) and (vars.lost == false) then
			menusys.button.disable("ui")
			unitsys.remove_byclass("guessprompt")
			menusys.button.erase("guessprompt")
			textsys.erase("guessprompt")
			
			local opts = {"a1","a10","a11","a12","a13","b1","b10","b11","b12","b13","c1","c10","c11","c12","c13","d1","d10","d11","d12","d13"}
			for i,opt in ipairs(opts) do
				if (opt ~= vars.victim) then
					local x = margin + screenw * 0.5 - 2.0 * 56 + 56 * ((i-1) % 5)
					local y = marginy + screenh * 0.5 - 3 * 42 + 84 * math.floor((i-1) / 5)
					local sprites
					
					for a,b in ipairs(UNITS) do
						if (b.class == "card") and (b.guess == opt) then
							sprites = {"frame"}
						end
					end
					
					local c = unitsys.find("card",opt)
					
					if (c ~= nil) then
						unitsys.create("cardbutton","guess_" .. opt,x,y,{_sprite = "card", _anim = opt, layer = 2, _sprites = sprites, title = c.title, card = opt})
					end
				end
			end
			
			-- unitsys.create("cardbutton","noguess",screenw * 0.5 - 3 * 56,screenh * 0.5 - 44,{_sprite = "card", _anim = "noguess", layer = 2})
			-- unitsys.create("cardbutton","cancel",screenw * 0.5 - 3 * 56,screenh * 0.5 + 44,{_sprite = "card", _anim = "cancel", layer = 2})
			
			local overlay = function() love.graphics.setColor(0.1, 0.1, 0.1, 0.95) love.graphics.rectangle("fill", 0, 0, screenw * scaling, screenh * scaling) love.graphics.setColor(1, 1, 1, 1) end
			ORDER[3] = {}
			ORDER[2].effect = overlay
			vars.mode = 3
			delay = 6
			audiosys.play("rustle")
			
			textsys.write("Who killed " .. vars.victim_title .. "?",screenw * 0.5,8,"guess",{font = "header", xoffset = -0.5, layer = 2})
			
			alert(screenw)
			
			-- menusys.button.create("cancel",screenw - 40,20,"guess",{_text = "Nevermind", w = 72, h = 24, layer = 2})
		end
	end,
	
	ready2 = function()
		unitsys.remove_byclass("cardbutton")
		textsys.erase("guess")
		
		local opts = {"a2","a3","a4","a5","a6","a7","a8","a9","b2","b3","b4","b5","b6","b7","b8","b9","c2","c3","c4","c5","c6","c7","c8","c9","d2","d3","d4","d5","d6","d7","d8","d9"}
		for i,opt in ipairs(opts) do
			local x = screenw * 0.5 - 3.5 * 56 + 56 * ((i-1) % 8)
			local y = screenh * 0.5 - 3 * 42 + 84 * math.floor((i-1) / 8)
			local sprites
			
			for a,b in ipairs(UNITS) do
				if (b.class == "card") and (b.guess == opt) then
					sprites = {"frame"}
				end
			end
			
			local c = unitsys.find("card",opt)
			
			if (c ~= nil) then
				local cb = unitsys.create("cardbutton","guess_" .. opt,x,y,{_sprite = "card", _anim = opt, layer = 2, _sprites = {"overlay"}, title = c.title, card = opt})
				spritesys.anim.set(cb.sprites[1],c.titleanim)
			end
		end
		
		-- unitsys.create("cardbutton","noguess",screenw * 0.5 - 3 * 56,screenh * 0.5 - 44,{_sprite = "card", _anim = "noguess", layer = 2})
		-- unitsys.create("cardbutton","cancel",screenw * 0.5 - 3 * 56,screenh * 0.5 + 44,{_sprite = "card", _anim = "cancel", layer = 2})
		
		vars.mode = 4
		delay = 2
		audiosys.play("rustle_high")
		
		textsys.write("What did " .. vars.guess_killer_title .. " use to kill " .. vars.victim_title .. "?",screenw * 0.5,8,"guess",{font = "header", xoffset = -0.5, layer = 2})
	end,
	
	ready3 = function()
		menusys.button.disable(nil,nil,"ready")
		
		if (vars.guess_killer == vars.killer) and (vars.guess_weapon == vars.weapon) then
			scripts.cancel()
			victory()
		else
			scripts.cancel()
			vars.lost = true
			addloss(game)
			audiosys.play("loss")
			
			ORDER[2] = {}
			local o = ORDER[2]
			local c = getrgb(0x57a3c9)
			local errors = vars.victim_title .. " was " .. vars.method .. " " .. vars.weapon_title .. " by " .. vars.killer_title
			o.effect = function() love.graphics.setColor(c) love.graphics.rectangle("fill", 0, math.floor((screenh * 0.5 - 48)) * scaling, screenw * scaling, 96 * scaling) love.graphics.setColor(1, 1, 1, 1) end
			textsys.write("YOU LOST",screenw * 0.5,screenh * 0.5 - 12,"wincount",{font = "serif", xoffset = -0.5, yoffset = -0.5, layer = 2})
			textsys.write(errors,screenw * 0.5,screenh * 0.5 + 12,"wincount",{font = "header", xoffset = -0.5, yoffset = -0.5, layer = 2})
		end
	end,
	
	victory = function()
		audiosys.play("victory")
		ORDER[2] = {}
		local o = ORDER[2]
		local c = getrgb(BACKCOL,1.5)
		local errors = vars.victim_title .. " was " .. vars.method .. " " .. vars.weapon_title .. " by " .. vars.killer_title
		o.effect = function() love.graphics.setColor(c) love.graphics.rectangle("fill", 0, math.floor((screenh * 0.5 - 48)) * scaling, screenw * scaling, 96 * scaling) love.graphics.setColor(1, 1, 1, 1) end
		textsys.write("VICTORY",screenw * 0.5,screenh * 0.5 - 12,"wincount",{font = "serif", xoffset = -0.5, yoffset = -0.5, layer = 2})
		textsys.write(errors,screenw * 0.5,screenh * 0.5 + 12,"wincount",{font = "header", xoffset = -0.5, yoffset = -0.5, layer = 2})
		
		if (vars.guests <= 12) and (undoed == false) then
			achievement("lowguess")
		end
	end,
	
	cancel = function()
		vars.mode = 0
		delay = 5
		unitsys.remove_byclass("cardbutton")
		textsys.erase("guess")
		menusys.button.erase("guess")
		menusys.button.erase("guessprompt")
		unitsys.remove_byclass("guessprompt")
		textsys.erase("guessprompt")
		ORDER[2] = nil
		ORDER[3] = nil
		vars.guess_killer = ""
		vars.guess_killer_title = ""
		vars.guess_weapon = ""
		
		menusys.button.enable("ui")
	end,
	
	hovereffect = function()
		for i,pile in pairs(piles) do
			if (i ~= "deck") and (i ~= "hand") then
				if pile.open or pile.open_place then
					if (pile.check_place == nil) or pile.check_place(pile) then
						local u = unitsys.create("hoverfx","hoverfx",pile.x + #pile.cards * pile.card_offsets[1],pile.y + #pile.cards * pile.card_offsets[2],{_sprite = "fx_hover", layer = 3})
						
						if (#pile.cards > 0) then
							unitsys.attach(u,pile.cards[#pile.cards],pile.card_offsets[1],pile.card_offsets[2])
						end
					end
				end
			end
		end
	end,
}

MOD_VARS =
{
	method = "",
	killer = "",
	killer_title = "",
	weapon = "",
	weapon_title = "",
	victim = "",
	victim_title = "",
	hints = {},
	turnsleft = 32,
	lost = false,
	guess_killer = "",
	guess_killer_title = "",
	guess_weapon = "",
	guests = 0,
}

murder_sprites =
{
	card =
	{
		file = "gfx/deck_murder",
		colourblind = true,
		w = 48,
		h = 80,
		default = "back",
		anim =
		{
			back = {0,4},
			back2 = {1,4},
			
			a1 = {0,0},
			a2 = {1,0},
			a3 = {2,0},
			a4 = {3,0},
			a5 = {4,0},
			a6 = {5,0},
			a7 = {6,0},
			a8 = {7,0},
			a9 = {8,0},
			a10 = {9,0},
			a11 = {10,0},
			a12 = {11,0},
			a13 = {12,0},
			
			b1 = {0,1},
			b2 = {1,1},
			b3 = {2,1},
			b4 = {3,1},
			b5 = {4,1},
			b6 = {5,1},
			b7 = {6,1},
			b8 = {7,1},
			b9 = {8,1},
			b10 = {9,1},
			b11 = {10,1},
			b12 = {11,1},
			b13 = {12,1},
			
			c1 = {0,2},
			c2 = {1,2},
			c3 = {2,2},
			c4 = {3,2},
			c5 = {4,2},
			c6 = {5,2},
			c7 = {6,2},
			c8 = {7,2},
			c9 = {8,2},
			c10 = {9,2},
			c11 = {10,2},
			c12 = {11,2},
			c13 = {12,2},
			
			d1 = {0,3},
			d2 = {1,3},
			d3 = {2,3},
			d4 = {3,3},
			d5 = {4,3},
			d6 = {5,3},
			d7 = {6,3},
			d8 = {7,3},
			d9 = {8,3},
			d10 = {9,3},
			d11 = {10,3},
			d12 = {11,3},
			d13 = {12,3},
		},
	},
	overlay =
	{
		file = "gfx/deck_murder_overlay",
		w = 48,
		h = 80,
		default = "none",
		anim =
		{
			none = {0,4},
			
			['0'] = {0,0},
			['1'] = {1,0},
			['2'] = {2,0},
			['3'] = {3,0},
			['4'] = {4,0},
			['5'] = {5,0},
			['6'] = {6,0},
			['7'] = {7,0},
			
			['8'] = {0,1},
			['9'] = {1,1},
			['10'] = {2,1},
			['11'] = {3,1},
			['12'] = {4,1},
			['13'] = {5,1},
			['14'] = {6,1},
			['15'] = {7,1},
			
			['16'] = {0,2},
			['17'] = {1,2},
			['18'] = {2,2},
			['19'] = {3,2},
			['20'] = {4,2},
			['21'] = {5,2},
			['22'] = {6,2},
			['23'] = {7,2},
			
			['24'] = {0,3},
			['25'] = {1,3},
			['26'] = {2,3},
			['27'] = {3,3},
			['28'] = {4,3},
			['29'] = {5,3},
			['30'] = {6,3},
			['31'] = {7,3},
		},
	},
	marker =
	{
		file = "gfx/murder_marker",
		w = 12,
		h = 12,
		default = "none",
		anim =
		{
			yes = {0,0},
			maybe = {1,0},
			no = {2,0},
			unsure = {3,0},
			
			none = {0,1},
			chosen = {1,1},
			hover = {2,1},
		},
	},
	column =
	{
		file = "gfx/murder_column",
		w = 48,
		h = 80,
		default = "none",
		anim =
		{
			[1] = {0,0},
			[2] = {1,0},
			[3] = {2,0},
			[4] = {3,0},
			[5] = {4,0},
			[6] = {5,0},
			[7] = {6,0},
			[8] = {7,0},
			[9] = {0,1},
			[10] = {1,1},
			[11] = {2,1},
			[12] = {3,1},
			[13] = {4,1},
			[14] = {5,1},
			[15] = {6,1},
			[16] = {7,1},
			[17] = {0,2},
			[18] = {1,2},
			[19] = {2,2},
			none = {3,2},
		},
	},
}