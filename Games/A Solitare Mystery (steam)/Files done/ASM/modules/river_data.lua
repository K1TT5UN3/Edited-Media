MOD_SCRIPTS =
{
	setup = function()
		piles = {}
		inputsys.ignore = true
		
		spritesys.change("card",river_sprites.card)
		spritesys.change("pile",river_sprites.pile)
        spritesys.add("suiticon","gfx/river_suits",river_sprites.suiticon)
		spritesys.add("ferryman", "gfx/river_ferryman",river_sprites.ferryman)
		spritesys.add("warning", "gfx/warning",river_sprites.warning)

		local origin = margin + 48
		local y = marginy + 64
		local spacing = 14
		
		local slotdata = {card_offsets = {0,18}, check_pick = scripts.pile_check_pick, check_place = scripts.pile_check_place, _anim = "pile"}
		piles.hand = unitsys.create("pile","hand",0,0,{open = false, card_offsets = {0,12}, _visible = false, hold_offsets = {0,0}, lerp = 1.0})
		piles.deck = unitsys.create("pile","deck",origin + (48 + spacing) * 3.5,y,{open = false, card_offsets = {0,-0.5}, _visible = false})
		piles.leftslot1 = unitsys.create("pile","leftslot1",origin + (48 + spacing) * 0,y,slotdata)
		piles.leftslot2 = unitsys.create("pile","leftslot2",origin + (48 + spacing) * 1,y,slotdata)
		piles.leftslot3 = unitsys.create("pile","leftslot3",origin + (48 + spacing) * 2,y,slotdata)
		piles.rightslot1 = unitsys.create("pile","rightslot1",origin + (48 + spacing) * 5,y,slotdata)
		piles.rightslot2 = unitsys.create("pile","rightslot2",origin + (48 + spacing) * 6,y,slotdata)
		piles.rightslot3 = unitsys.create("pile","rightslot3",origin + (48 + spacing) * 7,y,slotdata)

		river_piles = {}
		river_suits = {a = 1, b = 2, c = 3}
		river_piles[1] = {piles.leftslot1, piles.leftslot2, piles.leftslot3}
		river_piles[2] = {piles.rightslot1, piles.rightslot2, piles.rightslot3}
		for _, pile in ipairs(river_piles[1]) do
			pile.side = 1
		end
		for _, pile in ipairs(river_piles[2]) do
			pile.side = 2
		end
		vars.move_from = 1

		ferryman = unitsys.create("ferryman","ferryman",screenw/2,screenh/2)
		spritesys.zlayer.toback(ferryman)
		ferryman.y = screenh/2
		ferryman.x = piles.deck.x

		local cards = {"a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a11","a12","a13","b1","b2","b3","b4","b5","b6","b7","b8","b9","b10","b11","b12","b13","c1","c2","c3","c4","c5","c6","c7","c8","c9","c10","c11","c12","c13"}
		vars.num_cards = #cards
		
		local topdeck = {}
		local opt = gamesys.random(1, #cards)
		table.insert(topdeck, cards[opt])
		table.remove(cards, opt)
		opt = gamesys.random(1, #cards)
		while (string.sub(cards[opt], 1, 1) == string.sub(topdeck[1], 1, 1)) do
			opt = gamesys.random(1, #cards)
		end
		table.insert(topdeck, cards[opt])
		table.remove(cards, opt)
		opt = gamesys.random(1, #cards)
		while (string.sub(cards[opt], 1, 1) == string.sub(topdeck[1], 1, 1)) or (string.sub(cards[opt], 1, 1) == string.sub(topdeck[2], 1, 1)) do
			opt = gamesys.random(1, #cards)
		end
		table.insert(topdeck, cards[opt])
		table.remove(cards, opt)
		
		alert(tostring(#topdeck) .. ", " .. topdeck[1] .. ", " .. topdeck[2] .. ", " .. topdeck[3])

		for i=1,#cards+#topdeck do
			local name = ""
			if (#topdeck == 0) then
				opt = gamesys.random(1, #cards)
				name = cards[opt]
			else
				opt = 1
				name = topdeck[1]
			end
			local s = river_suits[string.sub(name, 1, 1)]
			local v = tonumber(string.sub(name, 2))
			
			local card = unitsys.create("card",name,piles.deck.x,piles.deck.y,{value = v, suit = s})
			card.pile = "deck"
			table.insert(piles.deck.cards, card)
			card.pileid = #piles.deck.cards
			
			if (#topdeck == 0) then
				table.remove(cards, opt)
			else
				table.remove(topdeck, 1)
			end
		end
		
		scripts.show_pile_counts(true)
	end,
	
	cleanup = function()
		unitsys.reset()
		spritesys.change("card",SPRITELIST.card)
		spritesys.change("pile",SPRITELIST.pile)
		textsys.erase("suitcount")
		river_piles = nil
		vars.move_from = nil
		river_suits = nil
	end,

TODO:	info = function(l)
TODO:        local text =
TODO:        {
TODO:		"- Move all cards across the $Ceb8ederiver$CW to $Ca7d962win$CW.",
TODO:		"- You can pile and move card stacks in $Ce3c188descending$CW (not necessarily $C74c0e6consecutive$CW) order and $Ce3c188alternating$CW suit.",
TODO:		"- You can $C74c0e6only$CW take card stacks from the side of the $Ceb8ederiver$CW you're $Ce3c188currently on$CW. The $Ce3c188boat$CW indicates the side you're on.",
TODO:		"- When you move a card stack $Ce3c188across$CW the $Ceb8ederiver$CW, you will $Ce3c188move to the same side$CW as you moved the stack to.",
TODO:		"- $Cff8383You lose$CW the game if there are ever $Ce3c1882+ more$CW $Cff8383Ferrets$CW than $C8bc8e7Rabbits$CW on the same side of the $Ceb8ederiver$CW while there's at least $C8bc8e71 Rabbit$CW on that side!",
TODO:		"- $Cff8383You lose$CW the game if there are ever $Ce3c1882+ more$CW $C8bc8e7Rabbits$CW than $Ca7d962Carrots$CW on the same side of the $Ceb8ederiver$CW while there's at least $Ca7d9621 Carrot$CW on that side!",
TODO:		}
TODO:        
        textsys.write(text,16,32,"info",{layer = l, font = "header", gap = 5, wrap = screenw - 32})
    end,
	
	gameflow = function()
		if (vars.mode == 0) then
			vars.mode_timer = vars.mode_timer + 1
			if (piletarget == nil) then
				piletarget = 0
			end
			
			if (vars.mode_timer > 30) and (vars.mode_timer % 3 == 0) then
				local pile = unitsys.find("pile","deck")
				
				if (#pile.cards > 0) then
					local card = pile.cards[#pile.cards]
					local slot = "leftslot" .. tostring(piletarget+1)
					spritesys.anim.set(card.sprite,card.name)
					cardtopile(card,slot)
					
					piletarget = (piletarget + 1) % 3
					
					audiosys.play("slip_short4")
				end
			end
			
			if (#piles.deck.cards == 0) then
				vars.mode = 1
				vars.mode_timer = 1
				piletarget = nil
				inputsys.ignore = false
			end
		elseif (delay == 0) then
			inputsys.ignore = false
			
			if (
				#piles.rightslot1.cards + #piles.rightslot2.cards + #piles.rightslot3.cards
				== vars.num_cards
			) then
				victory()
			end
			
			piles.leftslot1.card_offsets[2] = dynamicoffset_withinlimits(piles.leftslot1, 80, 320, 18)
			piles.leftslot2.card_offsets[2] = dynamicoffset_withinlimits(piles.leftslot2, 80, 320, 18)
			piles.leftslot3.card_offsets[2] = dynamicoffset_withinlimits(piles.leftslot3, 80, 320, 18)
			piles.rightslot1.card_offsets[2] = dynamicoffset_withinlimits(piles.rightslot1, 80, 320, 18)
			piles.rightslot2.card_offsets[2] = dynamicoffset_withinlimits(piles.rightslot2, 80, 320, 18)
			piles.rightslot3.card_offsets[2] = dynamicoffset_withinlimits(piles.rightslot3, 80, 320, 18)

			scripts.show_pile_counts()

			vars.warning_flash = (vars.warning_flash + 1) % 60
		end

		scripts.move_ferryman()
	end,

	move_ferryman = function()
        local river_left = piles.deck.x - vars.river_width
        local river_right = piles.deck.x + vars.river_width

        -- set target position
		if (vars.lost == false) then
			if #piles.hand.cards ~= 0 then
				vars.ferryman.target_x = piles.hand.x
				if vars.ferryman.target_x > river_right then
					vars.ferryman.target_x = river_right
				end
				if vars.ferryman.target_x < river_left then
					vars.ferryman.target_x = river_left
				end
			elseif vars.move_from == 1 then
				vars.ferryman.target_x = river_left
			else
				vars.ferryman.target_x = river_right
			end
		end

        -- set sprite
        if ferryman.x > vars.ferryman.target_x + 1 then
            spritesys.anim.set(ferryman.sprite, 1)
        end
        if ferryman.x < vars.ferryman.target_x - 1 then
            spritesys.anim.set(ferryman.sprite, 2)
        end

        -- move
        ferryman.x = ferryman.x + vars.ferryman.lerp * (vars.ferryman.target_x - ferryman.x)
    end,

	get_pile_counts = function(side)
		local counts = {0, 0, 0}
		for i = 1, 3 do
			local pile = river_piles[side][i]
			for _, card in ipairs(pile.cards) do
				counts[card.suit] = counts[card.suit] + 1
			end
		end
		if vars.move_from ~= side then
			for _, card in ipairs(piles.hand.cards) do
				counts[card.suit] = counts[card.suit] + 1
			end
		end
		return counts
	end,

	show_pile_counts = function(intro_)
		unitsys.remove_byclass("suiticon")
		unitsys.remove_byclass("warning")
		textsys.erase("suitcount")
		
		local intro = intro_ or false

		local unit
		for side = 1, 2 do
			local counts = scripts.get_pile_counts(side)

			local icon_y = screenh - 30 - marginy
			local icon_x = river_piles[side][2].x
			local icon_x_spacing = 23
			
			-- show warning
			local suits = scripts.check_loss(side)
			local alpha = (math.cos(2*math.pi*vars.warning_flash/60)+1)/2
			if suits ~= nil and alpha > 0.5 then
				unit = unitsys.create("warning", "warning" .. tostring(side), icon_x, icon_y + 8)
				spritesys.zlayer.toback(unit)
			end

			-- show counts
			for name, suit in pairs(river_suits) do
				local num = counts[suit]
			
				if intro and (side == 1) then
					num = 13
				end
				textsys.write(tostring(num), icon_x + suit*icon_x_spacing - 2*icon_x_spacing, icon_y + 15,"suitcount",{font = "header", layer = 0, xoffset = -0.5, yoffset = -0.5})
				unit = unitsys.create("suiticon", "side"..tostring(side).."suit"..tostring(suit), icon_x + suit*icon_x_spacing - 2*icon_x_spacing, icon_y, {_anim = name})
				spritesys.zlayer.toback(unit)
			end
		end
	end,
	
	mouse_left = function(key,data)
		if (vars.lost == false) then
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

		vars.warning_flash = 0
	end,
	
	place_card = function()
		local pile = piles[targetpile]
		local these = {}

		if pile.open or pile.open_place then
			if (pile.check_place == nil) or pile.check_place(pile) then
				local op = false
				for i,u in ipairs(piles.hand.cards) do
					if (u.oldpile == pile.name) then
						op = true
					end
					
					table.insert(these, u)
				end
				
				if (op == false) then
					for i,v in aipairs(these) do
						addundo({"cardtopile",v.id,v.pile})
					end
				end
				
				if (pile.side ~= vars.move_from) then
					addundo({"set_var", "move_from", vars.move_from})
					vars.move_from = vars.move_from % 2 + 1
					audiosys.play("water[1-3]")
				end
				
				for i,v in ipairs(these) do					
					cardtopile(v,targetpile)
				end
				
				if op then
					removeundo()
				end
				
				audiosys.play("slip_short3")

				if (op == false) then
					for side = 1, 2 do
						local suits = scripts.check_loss(side)
						if suits ~= nil then
							scripts.loss(suits[1], suits[2])
						end
					end
				end
			end
		end
	end,
	
	pile_check_pick = function(pile,card)
		if (not scripts.river_check_pick(pile)) then
			return false
		end
		
		local s = card.suit + 1
		local v = card.value + 1
		
		for i=card.pileid,#pile.cards do
			local c = pile.cards[i]
			if (
				c.suit == s or
				c.value >= v
			) then
				return false
			end
			
			s = c.suit
			v = c.value
		end
		
		return true
	end,
	
	pile_check_place = function(pile)
		local card = piles.hand.cards[1]
		local v = card.value
		local s = card.suit
		local op = card.oldpile
		
		-- if (op ~= pile.name) then
		-- 	if (not scripts.river_check_place(pile)) then
		-- 		return false
		-- 	end
		-- end

		if (#pile.cards > 0) and (op ~= pile.name) then
			local c = pile.cards[#pile.cards]
			
			if (
				c.suit == s or
				c.value <= v
		 	) then
				return false
			end
		end
		
		return true
	end,

	river_check_pick = function(pile)
		if pile.side == vars.move_from then
			return true
		else
			return false
		end
	end,

	river_check_place = function(pile)
		if pile.side ~= vars.move_from then
			return true
		else
			return false
		end
	end,

	check_loss = function(side)
		local counts = scripts.get_pile_counts(side)

		if counts[3] >= counts[2] + 2 and counts[2] ~= 0 then
			return {3,2}
		end
		if counts[2] >= counts[1] + 2 and counts[1] ~= 0 then
			return {2,1}
		end

		return nil
	end,

	loss = function(strongsuit, weaksuit)
		vars.lost = true
		addloss(game)
		audiosys.play("loss")

		local loss_message = string.format("Too many %s! %s were eaten...", vars.suit_names[strongsuit], vars.suit_names[weaksuit])
		
		ORDER[2] = {}
		local o = ORDER[2]
		local c = getrgb(0x523432)
		o.effect = function() love.graphics.setColor(c) love.graphics.rectangle("fill", 0, math.floor((screenh * 0.5 - 48)) * scaling, screenw * scaling, 96 * scaling) love.graphics.setColor(1, 1, 1, 1) end
		textsys.write("YOU LOST",screenw * 0.5,screenh * 0.5 - 12,"wincount",{font = "serif", xoffset = -0.5, yoffset = -0.5, layer = 3})
		textsys.write(loss_message,screenw * 0.5,screenh * 0.5 + 12,"wincount",{font = "header", xoffset = -0.5, yoffset = -0.5, layer = 3})
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
	lost = false,
	suit_names = {"Carrots", "Rabbits", "Ferrets"},
	move_from = 1,
	num_cards = 0,
	warning_flash = 0,
	ferryman = {
		target_x = 0,
		lerp = 0.1,
	},
	river_width = 30,
}

river_sprites =
{
	warning = {
		file = "gfx/warning",
		w = 16,
		h = 16,
		default = "warning",
		anim = {
			warning = {0,0},
		}
	},
	ferryman = {
		file = "gfx/river_ferryman",
		w = 64,
		h = 64,
		default = "1",
		anim = {
			{0,0},
			{1,0},
		},
	},
	suiticon =
	{
		file = "gfx/river_suits",
		colourblind = true,
		w = 23,
		h = 15,
		default = "a",
		anim = {
			a = {0,0},
			b = {1,0},
			c = {2,0},
		}
	},
	card =
	{
		file = "gfx/deck_river",
		colourblind = true,
		w = 48,
		h = 80,
		default = "back",
		colourblind = true,
		anim =
		{
			back = {0,3},
			lock_1 = {1,3},
			lock_2 = {2,3},
			
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
		},
	},
	pile =
	{
		file = "gfx/pile_thing",
		colourblind = true,
	},
}