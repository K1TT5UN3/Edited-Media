--[[
	TODO:
		visual bug: when autostacking a card to a time machine, it goes lower than the target
]]

MOD_SCRIPTS =
{
	setup = function()
		-- Config variables
		FULLY_RANDOM = false -- override the algorithm and just return random cards
		ALLOW_GREEN = true -- on fully random, can green cards appear?
		N_STARTING_COLUMNS = 6
		N_SLOTS = 7
		N_MACHINES = 7
		MIN_LOCK = 8
		MAX_LOCK = 19
		REQUIRE_EXACT = true

		spritesys.add("lock","gfx/time_clock",time_sprites.lock)

		piles = {}
		inputsys.ignore = true
		
		spritesys.change("card",time_sprites.card)
		-- spritesys.change("pile",{file = "gfx/pile_thing"})
		
		-- Array for holding cards flying to a machine. Used to run a callback when they get there (destroy card & anticard)
		cards_moving_to_machine = {}

		local origin = margin + 32
		local y = marginy + 64

		-- The endgoal slots
		local slotdata_end = {open = false, open_place = true, _anim = "pile_a", check_place = scripts.pile_check_place_end}
		piles.end1 = unitsys.create("pile","end1",origin + 56 * 8,y + 16 + 84 * 0,slotdata_end)
		slotdata_end._anim = "pile_b"
		piles.end2 = unitsys.create("pile","end2",origin + 56 * 8,y + 16 + 84 * 1,slotdata_end)
		slotdata_end._anim = "pile_c"
		piles.end3 = unitsys.create("pile","end3",origin + 56 * 8,y + 16 + 84 * 2,slotdata_end)
		slotdata_end._anim = "pile_d"
		piles.end4 = unitsys.create("pile","end4",origin + 56 * 8,y + 16 + 84 * 3,slotdata_end)
		
		-- Two special slots: the hand holding cards, & the deck for the initial animation
		piles.hand = unitsys.create("pile","hand",0,0,{open = false, card_offsets = {0,12}, _visible = false, hold_offsets = {0,0}, lerp = 1.0})
		piles.deck = unitsys.create("pile","deck",origin + 56 * 6,screenh * 0.5,{open = false, card_offsets = {0,-0.5}, _visible = false})
		
		-- The main slots
		local slotdata = {card_offsets = {0,12}, check_pick = scripts.pile_check_pick, check_place = scripts.pile_check_place, _anim = "pile_white"}

		slots = {} 
		for k=1,N_SLOTS do
			piles["slot" .. k] = unitsys.create("pile","slot"..k,origin + 56 * (k - 1),y,slotdata)
			slots[k] = piles["slot" .. k]
		end
		
		-- The time machines!
		machines = {}
        local machine_slotdata = {card_offsets = {0,0}, _anim = "pile_white"}
		for k=1,N_MACHINES do
			piles["machine" .. k] = unitsys.create("pile","machine"..k,origin + 56 * (k - 1),y + 16 + 84 * 3,machine_slotdata)
			machines[k] = piles["machine" .. k]
			piles["machine" .. k].used = false
		end

		local cards = {"a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a11","a12","a13","b1","b2","b3","b4","b5","b6","b7","b8","b9","b10","b11","b12","b13","c1","c2","c3","c4","c5","c6","c7","c8","c9","c10","c11","c12","c13","d1","d2","d3","d4","d5","d6","d7","d8","d9","d10","d11","d12","d13"}
		local suits = {a = 1, b = 2, c = 3, d = 4}
		
		for i=1,#cards do
			local opt = gamesys.random(1, #cards)
			local name = cards[opt]
			local s = suits[string.sub(name, 1, 1)]
			local v = tonumber(string.sub(name, 2))
			
			local card = unitsys.create("card",name,piles.deck.x,piles.deck.y,{value = v, suit = s})
			card.pile = "deck"
			table.insert(piles.deck.cards, card)
			card.pileid = #piles.deck.cards
			
			table.remove(cards, opt)
		end
	end,
	
    -- todo: understand this & maybe do something here
	cleanup = function()
		unitsys.reset()
		spritesys.change("card",SPRITELIST.card)
		spritesys.change("pile",SPRITELIST.pile)
		spritesys.delete("lock")
		machines = nil
	end,
	
	info = function(l)
		local text =
		{
		"- Pile cards of $Ca7d962every suit$CW in $Ce3c188ascending$CW order on the $Ceb8edeslots on the right$CW.",
		"- Cards are stacked in the $Ceb8edemiddle slots$CW in $Ce3c188descending$CW order of $Ce3c188alternating$CW color.",
		"- The bottom seven slots are $Ceb8edetime machines$CW. $C8bc8e7Left-click$CW them to receive a card from your $Ca7d962future self!",
		"- The numbers on the $Ca7d962future cards$CW indicate how many turns remain until they were/will be $Ce3c188sent back$CW. Failing to send them back in time will cause a paradox, $Cff8383losing the game$CW!",
		"- You can $Cd98079only$CW send a card back to prevent a paradox when it has $C8bc8e7exactly 1 turn remaining$CW. The card will also be coloured $Cd98079red$CW to indicate this.",
		"- Press S to autostack.",
		}
		
		textsys.write(text,16,32,"info",{layer = l, font = "header", gap = 5, wrap = screenw - 32})
	end,

	-- vars.mode 0: initial dealing of cards from the deck into the main slots
	-- vars.mode 1: rest of the game

	-- called every frame
	gameflow = function()
		for k=#cards_moving_to_machine,1,-1 do
			local card = cards_moving_to_machine[k]
			if math.abs(card.x - card.xp) + math.abs(card.y - card.yp) < 5 then
				table.remove(cards_moving_to_machine, k)
				local anticard = piles[card.pile].cards[1]	
				table.remove(piles[card.pile].cards)
				table.remove(piles[card.pile].cards)
				unitsys.remove(card.id)
				unitsys.remove(anticard.id)
			end
		end	

		if (vars.mode == 0) then
			-- initial dealing of the cards; no changes here

			vars.mode_timer = vars.mode_timer + 1
			if (piletarget == nil) then
				piletarget = 0
			end
			
			if (vars.mode_timer > 30) and (vars.mode_timer % 3 == 0) then
			-- if true then -- changed to a fast version; todo: change back
				local deck = unitsys.find("pile","deck")
				
				if (#deck.cards > 0) then
					local card = deck.cards[#deck.cards]
					local slot = "slot" .. tostring(piletarget+1)
					spritesys.anim.set(card.sprite,card.name)
					cardtopile(card,slot)
					
					piletarget = (piletarget + 1) % N_STARTING_COLUMNS
					
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
            -- normal frame with no pending actions; no changes here

			if (vars.autostack == 1) then
				scripts.autostack()
			else
				inputsys.ignore = false
				
				if (vars.lost == false) and (#piles.end1.cards == 13) and (#piles.end2.cards == 13) and (#piles.end3.cards == 13) and (#piles.end4.cards == 13) then
					victory()
					
					if vars.doach then
						achievement("alltime")
					end
				end
				
				-- set the vertical offset of each of the main slots
				for k, slot in ipairs(slots) do
					-- tried numbers a bit randomly, these work fine
					slot.card_offsets[2] = dynamicoffset(slot, 10, 4, 12)
				end
				
				piles.slot1.card_offsets[2] = dynamicoffset(piles.slot1, 13, 2, nil, nil, nil, screenh - marginy - 106)
				piles.slot2.card_offsets[2] = dynamicoffset(piles.slot2, 13, 2, nil, nil, nil, screenh - marginy - 106)
				piles.slot3.card_offsets[2] = dynamicoffset(piles.slot3, 13, 2, nil, nil, nil, screenh - marginy - 106)
				piles.slot4.card_offsets[2] = dynamicoffset(piles.slot4, 13, 2, nil, nil, nil, screenh - marginy - 106)
				piles.slot5.card_offsets[2] = dynamicoffset(piles.slot5, 13, 2, nil, nil, nil, screenh - marginy - 106)
				piles.slot6.card_offsets[2] = dynamicoffset(piles.slot6, 13, 2, nil, nil, nil, screenh - marginy - 106)
				piles.slot7.card_offsets[2] = dynamicoffset(piles.slot7, 13, 2, nil, nil, nil, screenh - marginy - 106)
			end
			
			for i,v in ipairs(machines) do
				if (#v.cards == 1) then
					local c = v.cards[1]
					if (c.lock == 1) then
						unitsys.create("fx_glitter","fade_yellow",c.x + math.random(-24, 24),c.y + math.random(-40, 40),{delete_after_anim = true, layer = 2, yv = math.random(-25,1) * 0.1, _anim = "fade_yellow"})
					end
				end
			end
		end
	end,
	
	autostack = function()
		vars.autostack = 0
		inputsys.ignore = false
		
		if (vars.lost == false) then
			-- don't autostack if there are urgent debts
			local urgent_debt = false
			if REQUIRE_EXACT then
				for k=1,#machines do
					local machine = machines[k]
					if (#machine.cards == 1) then
						if (machine.cards[1].lock == 1) then
							urgent_debt = true
						end
					end
				end
			end
			
			for i,unit in ipairs(UNITS) do
				if (unit.class == "card") and (delay == 0) and (#piles.hand.cards == 0) and (vars.mode == 1) and (#unit.pile > 0) 
					and (unit.pile ~= "hand") and (unit.pile ~= "deck") and (not scripts.is_machine(unit.pile)) then
					if (autostack_undocheck == false) then
						newundoneeded = true
						autostack_undocheck = true
					end

					local suitpilename = "end" .. tostring(unit.suit)
					local suitpile = piles[suitpilename]
					local pile = piles[unit.pile]

					-- when autostacking, first priority is to pay time debts
					if (unit.pileid == #pile.cards) and (pile ~= suitpile) and (delay == 0) then
						for k=1,#machines do
							local machinename = "machine" .. tostring(k)
							local machine = piles[machinename]
							if (#machine.cards == 1) then
								local machine_anticard = machine.cards[1]
								if (machine_anticard.suit == unit.suit) and (machine_anticard.value == unit.value) and (machine_anticard.lock == 1) then
									addundo({"cardtopile",unit.id,unit.pile})
									scripts.anim_card_to_machine(unit, machinename)
									delay = 5
									vars.autostack = 1
									scripts.advance_locks()
									return
								end
							end
						end
					end

					-- if that can't be done, next priority are the end piles				
					if (not urgent_debt) and (unit.suit ~= 5) and (unit.pileid == #pile.cards) and (unit.value == #suitpile.cards+1) and (delay == 0) then
						inputsys.ignore = true
						vars.autostack = 1
						delay = 5
						addundo({"cardtopile",unit.id,unit.pile})
						cardtopile(unit,suitpilename)
						scripts.advance_locks()
						audiosys.play("slip_short4")
						return
					end
				end
			end
		end
	end,
	
	mouse_left = function(key,data)
		if (vars.lost == false) then
			-- special case: the player can pick a card from an empty machine
			if (targetpile ~= nil) and (scripts.is_machine(piles[targetpile])) and (#piles.hand.cards == 0) and (#piles[targetpile].cards == 0) and (delay == 0) then
				local machine = piles[targetpile]
				scripts.machine_pick_card (machine)
				machine.used = true
				delay = 5
			end

			-- pick cards from a normal pile
			if (targetcard ~= nil) and (#piles.hand.cards == 0) and (not scripts.is_machine(piles[targetpile])) and (delay == 0) then
				local unit = targetcard
				local pile = unitsys.find("pile",unit.pile)

				if pile.open or pile.open_pick then
					scripts.pick_card(unit)
					delay = 5
				end
			end
			
			-- drop cards into a normal pile or a time machine
			if (targetpile ~= nil) and (#piles.hand.cards > 0) and (delay == 0) then
				-- special case: drop a single card into a full machine
				if (scripts.is_machine(piles[targetpile])) then
					scripts.machine_place_card(piles[targetpile])	
				else
					scripts.place_card()
				end
				delay = 5
			end
		end
	end,

    machine_pick_card = function(machine_pile)
        -- knexator todo: better logic
		
		-- Only get 2 types of cards:
		-- - Cards that can be placed at the end of a non-empty slot (extra points if it allows moving some other stack)
		-- - Cards that can be directly moved to the end (extra points if it allows ending some other card)
		
		-- type: nil | {value: int, blue: bool (can the card be blue?), red, green}
		local placeable_at_slot = {}
		-- First, find all cards that can be placed at the end of a slot
		for k, slot in ipairs(slots) do
			if (#slot.cards ~= 0) then 
				local last_card = slot.cards[#slot.cards]
				if last_card.value > 2 then -- don't bother placing an ace on a slot
					placeable_at_slot[k] = {
						value = last_card.value - 1,
						blue = (last_card.suit ~= 1 and last_card.suit ~= 2),
						red = (last_card.suit ~= 3 and last_card.suit ~= 4),
						green = last_card.suit ~= 5
					}
				else
					placeable_at_slot[k] = nil
				end
			end
		end
		-- Now, search for bridge cards
		local bridge_cards = {} -- type: {value: int, color: "blue" | "red" | "green"} 
		for k, slot in ipairs(slots) do
			if (#slot.cards ~= 0) then 
				local top_card = slot.cards[#slot.cards]
				for k=#slot.cards - 1,1,-1 do
					if scripts.pile_check_pick(slot, slot.cards[k]) then
						top_card = slot.cards[k]
					else
						break
					end
				end
				for k2, slot in ipairs(slots) do
					if k2 ~= k and placeable_at_slot[k2] ~= nil then
						if top_card.value + 1 == placeable_at_slot[k2].value then
							local bridge_card = placeable_at_slot[k2]
							-- if a red or blue card will do, don't bring a green one
							local blue = top_card.suit == 1 or top_card.suit == 2
							local red = top_card.suit == 3 or top_card.suit == 4
							local green = top_card.suit == 3
							if blue then
								if bridge_card.red then
									table.insert(bridge_cards, {
										value = bridge_card.value,
										color = "red"
									})
								elseif bridge_card.green then
									table.insert(bridge_cards, {
										value = bridge_card.value,
										color = "green"
									})
								end
							elseif red then
								if bridge_card.blue then
									table.insert(bridge_cards, {
										value = bridge_card.value,
										color = "blue"
									})
								elseif bridge_card.green then
									table.insert(bridge_cards, {
										value = bridge_card.value,
										color = "green"
									})
								end
							elseif green then
								if bridge_card.blue then
									table.insert(bridge_cards, {
										value = bridge_card.value,
										color = "blue"
									})
								elseif bridge_card.red then
									table.insert(bridge_cards, {
										value = bridge_card.value,
										color = "red"
									})
								end
							end
						end
					end
				end
			end
		end

		-- Second, find all cards that can be placed on an ending pile
		local placeable_at_end = {}
		local place_end_extra_points = {}
		for suit=1,4 do
			local end_pile = piles["end" .. tostring(suit)]
			local next_value = (#end_pile.cards == 0) and 1 or (#end_pile.cards + 1) 
			if next_value <= 13 then
				placeable_at_end[suit] = next_value
			else
				placeable_at_end[suit] = nil
			end
			place_end_extra_points[suit] = 0 -- for later
		end
		-- Extra points if they enable moving another card around
		for k, slot in ipairs(slots) do
			if (#slot.cards ~= 0) then 
				local last_card = slot.cards[#slot.cards]
				if placeable_at_end[last_card.suit] ~= nil and last_card.value == 1 + placeable_at_end[last_card.suit] then
					print("extra: " .. tostring(last_card.suit))
					place_end_extra_points[last_card.suit] = 1
				end
			end
		end
		
		-- Current algorithm: 
		-- - bridging card: 10 points
		-- - end pile and followed by another: 6 points
		-- - end pile, vanilla: 2 points
		-- - placeable: 1 point
		-- more points = more probable
		-- If exact placement is on and a card is about to expire, that has max priority
		local card_prob = {}
		for s=1,5 do
			local cur = {}	
			for v=1,13 do
				cur[v] = 0
			end
			card_prob[s] = cur
		end
		
		for k, tail_card in ipairs(placeable_at_slot) do
			if tail_card ~= nil then
				if tail_card.blue then
					card_prob[1][tail_card.value] = 1
					card_prob[2][tail_card.value] = 1
				end
				if tail_card.red then
					card_prob[3][tail_card.value] = 1
					card_prob[4][tail_card.value] = 1
				end
				if tail_card.green then
					card_prob[5][tail_card.value] = 1
				end
			end
		end
		for suit=1,4 do
			if placeable_at_end[suit] ~= nil then
				card_prob[suit][placeable_at_end[suit]] = 2 + 4 * place_end_extra_points[suit]
			end
		end
		for k, bridge_card in ipairs(bridge_cards) do
			if bridge_card.color == "blue" then
				card_prob[1][bridge_card.value] = 10
				card_prob[2][bridge_card.value] = 10
			elseif bridge_card.color == "red" then
				card_prob[3][bridge_card.value] = 10
				card_prob[4][bridge_card.value] = 10
			else
				card_prob[5][bridge_card.value] = 10
			end
		end
		
		-- don't allow cards that are already accesible
		local old_prob = {}
		for k, slot in ipairs(slots) do
			if (#slot.cards ~= 0) then 
				local last_card = slot.cards[#slot.cards]
				table.insert(old_prob, {card=last_card, prob=card_prob[last_card.suit][last_card.value]})
				card_prob[last_card.suit][last_card.value] = 0
			end
		end
		local total_prob = 0
		for s=1,5 do
			for v=1,13 do
				total_prob = total_prob + card_prob[s][v]
			end
		end
		
		-- no valid cards, so let's relax the "no already accesible cards" constraint
		if total_prob == 0 then
			for k, thing in ipairs(old_prob) do
				card_prob[thing.card.suit][thing.card.value] = math.max(card_prob[thing.card.suit][thing.card.value], thing.prob)
			end
		end
		
		local random_value = gamesys.random(total_prob) - 1
		local selected_card = {value = 1, suit = 1}
		for s=1,5 do
			for v=1,13 do
				random_value = random_value - card_prob[s][v] 
				if random_value < 0 then
					selected_card = {value = v, suit = s}
					goto loop_end	
				end
			end
		end
		::loop_end::
        local new_card_value = selected_card.value 
        local new_card_suit = selected_card.suit

		if REQUIRE_EXACT then
			for k=1,#machines do
				local machine = machines[k]
				if (#machine.cards == 1) then
					local anticard = machine.cards[1]
					if anticard.lock == 1 then
						new_card_value = anticard.value
						new_card_suit = anticard.suit
					end
				end
			end
		end

		if FULLY_RANDOM then
			-- no logic, just return a random card
			new_card_value = gamesys.random(1, 13)
			if ALLOW_GREEN then
				new_card_suit = gamesys.random(1, 5)
			else
				new_card_suit = gamesys.random(1, 4)
			end
		end

        local suit_names = {"a", "b", "c", "d", "e"}
        local card_name = suit_names[new_card_suit] .. tostring(new_card_value)
		local anticard_name = "anti_" .. card_name
		
		-- create a new card-anticard pair
		
		-- avoid making a card that will have to return at the same time as another
		local future_turns = gamesys.random(MIN_LOCK,MAX_LOCK)
		while true do
			local valid_choice = true
			for k=1,#machines do
				local machine = machines[k]
				if (#machine.cards == 1) then
					if future_turns == machine.cards[1].lock then
						valid_choice = false
						break
					end
				end
			end
			if valid_choice then
				break
			end
			future_turns = gamesys.random(MIN_LOCK,MAX_LOCK)
		end
		newundoneeded = true
		local new_anticard = unitsys.create("card",anticard_name,machine_pile.x,machine_pile.y,{value = new_card_value, suit = new_card_suit, lock=future_turns, _sprites = {"lock"}})
        local new_card = unitsys.create("card",card_name,machine_pile.x,machine_pile.y,{value = new_card_value, suit = new_card_suit})
		addundo({"card_from_time_machine",new_card.id,machine_pile.name})

		spritesys.anim.set(new_card.sprite,card_name)
		spritesys.anim.set(new_anticard.sprite,anticard_name)
		spritesys.anim.set(new_anticard.sprites[1], "lock_" .. tostring(new_anticard.lock))
        
		local mx,my = love.mouse.getPosition()
		mx = math.floor(mx / scaling)
		my = math.floor(my / scaling)
		piles.hand.hold_offsets[1] = mx - machine_pile.x
		piles.hand.hold_offsets[2] = my - machine_pile.y
		
		cardtopile(new_anticard,machine_pile.name)
		cardtopile(new_card,"hand")
		audiosys.play("slip_reverse")
    end,
	
	-- no changes
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
			
			local ach = true
			for k=1,#machines do
				local machine = machines[k]
				if (#machine.cards == 0) then
					ach = false
				end
			end
			if ach then
				vars.doach = true
			end
		end
	end,
	
    is_machine = function(pile)
		local pile_name = pile
		if type(pile) ~= "string" then
			pile_name = pile.name
		end
		return string.sub(pile_name, 1, #"machine") == "machine"
    end,
	
	machine_place_card = function(machine_pile)
		if (#piles.hand.cards == 1) and (#machine_pile.cards == 1) then
			local hand_card = piles.hand.cards[1]
			local machine_anticard = machine_pile.cards[1]
			if (hand_card.value == machine_anticard.value) and (hand_card.suit == machine_anticard.suit) and (machine_anticard.lock == 1) then
				scripts.anim_card_to_machine(hand_card, machine_pile.name)
				scripts.advance_locks()
			end
		end
	end,

	anim_card_to_machine = function(card, machinename)
		cardtopile(card, machinename)
		local anticard = piles[card.pile].cards[1]
		addundo({"cardto_time_machine",card.value,card.suit,anticard.lock,machinename,card.pile,card.id,anticard.id})
		table.insert(cards_moving_to_machine, card)
		audiosys.play("slip_reverse2")
	end,

	advance_locks = function()
		-- a lock of 0 means a lost card
		local lost = false
		
		for k=1,#machines do
			local machine = machines[k]
			if (#machine.cards == 1) then
				local machine_anticard = machine.cards[1]
				
				if machine_anticard.lock > 0 then
					addundo({"advance_lock",machine_anticard.id})
					machine_anticard.lock = machine_anticard.lock - 1
					
					if (machine_anticard.lock == 0) then
						lost = true
					end
				end

				-- DESIGN: do cards come from "at least N turns in the future" or "exactly N turns in the future"?
				if (not REQUIRE_EXACT) and (machine_anticard.lock == 0) then
					machine_anticard.lock = 1
				end

				spritesys.anim.set(machine_anticard.sprites[1], "lock_" .. tostring(machine_anticard.lock))
			end
		end
		
		if lost then
			vars.lost = true
			addloss(game)
			audiosys.play("loss")
			
			ORDER[3] = {}
			local o = ORDER[3]
			local c = getrgb(0x3a4262)
			o.effect = function() love.graphics.setColor(c) love.graphics.rectangle("fill", 0, math.floor((screenh * 0.5 - 48)) * scaling, screenw * scaling, 96 * scaling) love.graphics.setColor(1, 1, 1, 1) end
			textsys.write("YOU LOST",screenw * 0.5,screenh * 0.5,"wincount",{font = "serif", xoffset = -0.5, yoffset = -0.5, layer = 3})
		end
	end,
	
	-- no changes
	-- i can't reuse this method for placing cards on machines, since that move destroys the card instead of moving it
	place_card = function()
		local pile = piles[targetpile]
		local these = {}
		
		if pile.open or pile.open_place then
			if (pile.check_place == nil) or pile.check_place(pile) then
				local lock = false
				local c = piles.hand.cards[1]
				if (c.oldpile ~= targetpile) then
					lock = true
				end

				for i,u in ipairs(piles.hand.cards) do
					table.insert(these, u)
				end
				
				if (lock == false) then
					for i,v in aipairs(these) do
						addundo({"cardtopile",v.id,v.pile})
					end
				end
				
				for i,v in ipairs(these) do					
					cardtopile(v,targetpile)
				end

				if lock then
					scripts.advance_locks()
				else
					removeundo()
				end
				
				audiosys.play("slip_short3")
			end
		end
	end,
	
	is_suit_pair_valid = function(suit_base, suit_top)
		-- green cards
		if (suit_base == 5) or (suit_top == 5) then
			return suit_top ~= suit_base
		end
		-- red and blue
		local is_base_blue = (suit_base == 1) or (suit_base == 2)
		local is_top_blue = (suit_top == 1) or (suit_top == 2)
		return is_base_blue ~= is_top_blue
	end,

	-- windows xp picking rules 
	pile_check_pick = function(pile,card)
		local s = card.suit
		local v = card.value
		for i=card.pileid+1,#pile.cards do
			local c = pile.cards[i]
			if (not scripts.is_suit_pair_valid(c.suit, s)) or ((c.value + 1) ~= v) then
				return false
			end
			v = c.value
			s = c.suit
		end
		
		return true
	end,
	
	-- windows xp solitaire stacking rules
	pile_check_place = function(pile)
		local card = piles.hand.cards[1]
		local v = card.value
		local s = card.suit
		local op = card.oldpile
		
		if (#pile.cards > 0) and (op ~= pile.name) then
			local c = pile.cards[#pile.cards]
			if (not scripts.is_suit_pair_valid(s, c.suit)) or (c.value ~= (v + 1)) then
				return false
			end
		end
		
		return true
	end,
	
	-- no changes
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
	
	hovereffect = function()
		for i,pile in pairs(piles) do
			if (i ~= "deck") and (i ~= "hand") then
				if pile.open or pile.open_place then
					if (pile.check_place == nil) or pile.check_place(pile) then
						if (string.sub(i, 1, 7) ~= "machine") then
							unitsys.create("hoverfx","hoverfx",pile.x + #pile.cards * pile.card_offsets[1],pile.y + #pile.cards * pile.card_offsets[2],{_sprite = "fx_hover", layer = 3})
						elseif (#piles.hand.cards == 1) and (#pile.cards == 1) then
							local machine_anticard = pile.cards[1]
							if (machine_anticard.lock == 1) and (machine_anticard.suit == piles.hand.cards[1].suit) and (machine_anticard.value == piles.hand.cards[1].value) then
								local u = unitsys.create("hoverfx","hoverfx",pile.x,pile.y,{_sprite = "fx_hover", layer = 3})
								
								if (#pile.cards > 0) then
									unitsys.attach(u,pile.cards[#pile.cards],0,0)
								end
							end
						end
					end
				end
			end
		end
	end,
	
	undo_before = function()
		for k=#cards_moving_to_machine,1,-1 do
			local card = cards_moving_to_machine[k]
			table.remove(cards_moving_to_machine, k)
			local anticard = piles[card.pile].cards[1]	
			table.remove(piles[card.pile].cards)
			table.remove(piles[card.pile].cards)
			unitsys.remove(card.id)
			unitsys.remove(anticard.id)
		end	
	end,
}

-- no changes
MOD_VARS =
{
	autostack = 0,
	lost = false,
	doach = false
}

-- no changes
time_sprites =
{
	lock =
	{
		file = "gfx/time_lock",
		w = 48,
		h = 80,
		default = "lock_0",
		anim =
		{
			lock_0 = {0,0},
			lock_1 = {1,0},
			lock_2 = {2,0},
			lock_3 = {3,0},
			lock_4 = {4,0},
			lock_5 = {5,0},
			lock_6 = {6,0},
			lock_7 = {7,0},
			lock_8 = {8,0},
			lock_9 = {9,0},
			lock_10 = {0,1},
			lock_11 = {1,1},
			lock_12 = {2,1},
			lock_13 = {3,1},
			lock_14 = {4,1},
			lock_15 = {5,1},
			lock_16 = {6,1},
			lock_17 = {7,1},
			lock_18 = {8,1},
			lock_19 = {9,1},
		},
	},

	card =
	{
		file = "gfx/deck_time",
		w = 48,
		h = 80,
		default = "back",
		anim =
		{
			back = {0,5},
			a20 = {1,5},
			
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

			e1 = {0,4},
			e2 = {1,4},
			e3 = {2,4},
			e4 = {3,4},
			e5 = {4,4},
			e6 = {5,4},
			e7 = {6,4},
			e8 = {7,4},
			e9 = {8,4},
			e10 = {9,4},
			e11 = {10,4},
			e12 = {11,4},
			e13 = {12,4},

			anti_a1 = {0,6},
			anti_a2 = {1,6},
			anti_a3 = {2,6},
			anti_a4 = {3,6},
			anti_a5 = {4,6},
			anti_a6 = {5,6},
			anti_a7 = {6,6},
			anti_a8 = {7,6},
			anti_a9 = {8,6},
			anti_a10 = {9,6},
			anti_a11 = {10,6},
			anti_a12 = {11,6},
			anti_a13 = {12,6},

			anti_b1 = {0,7},
			anti_b2 = {1,7},
			anti_b3 = {2,7},
			anti_b4 = {3,7},
			anti_b5 = {4,7},
			anti_b6 = {5,7},
			anti_b7 = {6,7},
			anti_b8 = {7,7},
			anti_b9 = {8,7},
			anti_b10 = {9,7},
			anti_b11 = {10,7},
			anti_b12 = {11,7},
			anti_b13 = {12,7},

			anti_c1 = {0,8},
			anti_c2 = {1,8},
			anti_c3 = {2,8},
			anti_c4 = {3,8},
			anti_c5 = {4,8},
			anti_c6 = {5,8},
			anti_c7 = {6,8},
			anti_c8 = {7,8},
			anti_c9 = {8,8},
			anti_c10 = {9,8},
			anti_c11 = {10,8},
			anti_c12 = {11,8},
			anti_c13 = {12,8},

			anti_d1 = {0,9},
			anti_d2 = {1,9},
			anti_d3 = {2,9},
			anti_d4 = {3,9},
			anti_d5 = {4,9},
			anti_d6 = {5,9},
			anti_d7 = {6,9},
			anti_d8 = {7,9},
			anti_d9 = {8,9},
			anti_d10 = {9,9},
			anti_d11 = {10,9},
			anti_d12 = {11,9},
			anti_d13 = {12,9},

			anti_e1 = {0,10},
			anti_e2 = {1,10},
			anti_e3 = {2,10},
			anti_e4 = {3,10},
			anti_e5 = {4,10},
			anti_e6 = {5,10},
			anti_e7 = {6,10},
			anti_e8 = {7,10},
			anti_e9 = {8,10},
			anti_e10 = {9,10},
			anti_e11 = {10,10},
			anti_e12 = {11,10},
			anti_e13 = {12,10},
		},
	},
}