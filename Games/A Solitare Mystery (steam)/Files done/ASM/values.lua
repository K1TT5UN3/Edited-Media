GAME =
{
	title = "A Solitaire Mystery",
	width = 568,
	height = 380,
	colour_back = 0,
	scaling = 2.0,
	scaling_int = true,
	filter = "nearest",
	linestyle = "rough",
	version = "1.5.12b",
}

SNAPDELAY = 24

SPRITELIST =
{
	card =
	{
		file = "gfx/deck",
		w = 48,
		h = 80,
		default = "back",
		anim =
		{
			back = {0,4},
			pile_light = {1,4},
			pile_dark = {2,4},
			pile = {3,4},
			pile_white = {4,4},
			
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
	pile =
	{
		file = "gfx/pile",
		w = 48,
		h = 80,
		default = "pile",
		anim =
		{
			pile_light = {0,0},
			pile_dark = {1,0},
			pile = {2,0},
			pile_white = {3,0},
			pile_a = {0,1},
			pile_b = {1,1},
			pile_c = {2,1},
			pile_d = {3,1},
		},
	},
	icon =
	{
		file = "gfx/icons",
		w = 48,
		h = 80,
		default = "thing",
		anim =
		{
			thing = {0,0},
			babaex = {1,0},
			babataire = {2,0},
			eldritch = {3,0},
			cheat = {4,0},
			wolf = {5,0},
			poker = {6,0},
			lock = {0,1},
			single = {1,1},
			binary = {2,1},
			alchemy = {3,1},
			big = {4,1},
			code = {5,1},
			limited = {6,1},
			random = {0,2},
			swap = {1,2},
			hanoi = {2,2},
			fork = {4,2},
			solitairdle = {3,2},
			stack = {5,2},
			tear = {6,2},
			murder = {2,3},
			fiftytwo = {0,3},
			time = {1,3},
			bandit = {2,3},
			garden = {3,3},
            reverse = {4,3},
			solar = {5,3},
			doubleside = {6,3},
			melon = {0,4},
			elec = {1,4},
			quant = {2,4},
			key = {3,4},
			river = {4,4},
			set = {4,4},
		},
	},
	thumbnail =
	{
		file = "gfx/games",
		w = 284,
		h = 192,
		default = "start",
		anim =
		{
			start = {0,0},
			babataire = {1,0},
			babaex = {2,0},
			wolf = {3,0},
			cheat = {0,1},
			eldritch = {1,1},
			lock = {2,1},
			poker = {3,1},
			thing = {0,2},
			single = {1,2},
			binary = {2,2},
			alchemy = {3,2},
			big = {0,3},
			code = {1,3},
			limited = {2,3},
			random = {3,3},
			swap = {0,4},
			hanoi = {1,4},
			fork = {2,4},
			solitairdle = {3,4},
			stack = {0,5},
			tear = {1,5},
			murder = {3,6},
			fiftytwo = {2,5},
			-- bandit = {0,6},
			time = {1,6},
			garden = {0,6},
            reverse = {3,5},
			solar = {2,6},
			doubleside = {1,7},
			melon = {0,0},
			elec = {0,7},
			quant = {2,7},
			key = {3,7},
			river = {0,8},
			set = {0,8},
		},
	},
	button =
	{
		file = "gfx/buttons",
		w = 18,
		h = 18,
		default = "close",
		anim =
		{
			close = {0,0},
			restart = {1,0},
			info = {2,0},
			stack = {3,0},
			setup = {4,0},
			undo = {5,0},
			music = {6,0},
		},
	},
	slider =
	{
		file = "gfx/slider_knob",
		w = 12,
		h = 12,
	},
	prize =
	{
		file = "gfx/prize",
		w = 12,
		h = 12,
		default = "none",
		anim =
		{
			a = {0,0},
			b = {1,0},
			c = {2,0},
			double = {3,0},
			none = {4,0},
		},
	},
	underlay =
	{
		file = "gfx/underlay",
		w = 568,
		h = 380,
		xoffset = 284,
		yoffset = 190,
		default = "babataire",
		anim =
		{
			babataire = {0,0},
			babaex = {1,0},
			wolf = {2,0},
			cheat = {3,0},
			eldritch = {4,0},
			lock = {0,1},
			poker = {1,1},
			thing = {2,1},
			single = {3,1},
			binary = {4,1},
			alchemy = {0,2},
			big = {1,2},
			-- code = {2,2},
			limited = {2,2},
			random = {3,2},
			swap = {4,2},
			hanoi = {0,3},
			fork = {1,3},
			solitairdle = {2,3},
			stack = {3,3},
			tear = {4,3},
			murder = {2,5},
			fiftytwo = {0,4},
			-- bandit = {0,6},
			time = {1,4},
			garden = {2,4},
            reverse = {3,4},
			solar = {4,4},
			doubleside = {0,5},
			melon = {0,0},
			elec = {1,5},
			garden_cb = {3,5},
			quant = {4,5},
			key = {0,6},
			river = {1,6},
		},
	},
	fx =
	{
		file = "gfx/fx",
		w = 48,
		h = 80,
		default = "flash",
		anim =
		{
			flash = {0,0,10,1,2, loop = false},
			chaos = {0,1,10,1,2, loop = false},
			eat = {0,2,15,1,2, loop = false},
		},
	},
	fx_wide =
	{
		file = "gfx/fx_wide",
		w = 64,
		h = 80,
		default = "tear",
		anim =
		{
			tear = {0,0,6,1,2, loop = false},
			blood = {0,1,6,1,2, loop = false},
		},
	},
	fx_glitter =
	{
		file = "gfx/glitter",
		w = 10,
		h = 10,
		default = "fade_blue",
		anim =
		{
			fade_blue = {0,0,5,1,6, loop = false},
			fade_yellow = {0,1,5,1,6, loop = false},
			fade_green = {0,2,5,1,6, loop = false},
		},
	},
	fx_hover =
	{
		file = "gfx/hover",
		w = 48,
		h = 80,
		anim =
		{
			default = {0,0,8,1,6},
		},
	},
}

UNITLIST =
{
	card =
	{
		pile = "deck",
		pileid = 0,
		open = true,
		open_place = false,
		open_pick = false,
		suit = 0,
		value = 0,
		oldpile = "",
		poscorrect = 0,
	},
	pile =
	{
		cards = {},
		open = true,
		card_offsets = {0,0},
		homesuit = 0,
	},
}

AUDIOLIST =
{
	slip =
	{
		file = "sfx/mydo1_page-turn.ogg",
		pitch_range = {-0.25,0.5},
	},
	slip_short1 =
	{
		file = "sfx/mydo1_page-turn_short1.ogg",
		pitch_range = {-0.25,0.5},
	},
	slip_short2 =
	{
		file = "sfx/mydo1_page-turn_short2.ogg",
		pitch_range = {-0.25,0.5},
	},
	slip_short3 =
	{
		file = "sfx/mydo1_page-turn_short3.ogg",
		pitch_range = {-0.25,0.5},
	},
	slip_short4 =
	{
		file = "sfx/mydo1_page-turn_short4.ogg",
		pitch_range = {-0.25,0.75},
		copy = 4,
	},
	tear =
	{
		file = "sfx/keweldog_tearing-paper.ogg",
		pitch_range = {-0.5,0.5},
	},
	crunch =
	{
		file = "sfx/iujhu_footstep-snow.ogg",
		pitch_range = {-0.5,0.5},
	},
	rustle =
	{
		file = "sfx/martian_foley-cloth-rustle.ogg",
		pitch_range = {-0.5,0.5},
	},
	rustle_high =
	{
		file = "sfx/martian_foley-cloth-rustle-high.ogg",
		pitch_range = {-0.5,0.5},
	},
	cash_register =
	{
		file = "sfx/kyles_cash-register[1-3].ogg",
	},
	cash_register_ding =
	{
		file = "sfx/kyles_cash-register-ding.ogg",
	},
	slip_reverse =
	{
		file = "sfx/mydo1_page-turn-reverse.ogg",
		pitch_range = {-0.25,0.5},
	},
	slip_reverse2 =
	{
		file = "sfx/mydo1_page-turn-reverse2.ogg",
		pitch_range = {-0.25,0.5},
	},
	transmute =
	{
		file = "sfx/alchemy.ogg",
		pitch_range = {-0.25,0.25},
	},
	elec_on =
	{
		file = "sfx/elec_on.ogg",
		pitch_range = {-0.25,0.25},
	},
	elec_off =
	{
		file = "sfx/elec_off.ogg",
		pitch_range = {-0.25,0.25},
	},
	error1 =
	{
		file = "sfx/error1.ogg",
		pitch_range = {-0.1,0.2},
	},
	error2 =
	{
		file = "sfx/error2.ogg",
		pitch_range = {-0.1,0.2},
	},
	correct1 =
	{
		file = "sfx/correct1.ogg",
		pitch_range = {-0.1,0.2},
	},
	correct2 =
	{
		file = "sfx/correct2.ogg",
		pitch_range = {-0.1,0.2},
	},
	start =
	{
		file = "sfx/start.ogg",
		pitch_range = {-0.1,0.1},
	},
	kronk1 =
	{
		file = "sfx/kronk1.ogg",
		pitch_range = {-0.25,0.5},
	},
	kronk2 =
	{
		file = "sfx/kronk1.ogg",
		pitch_range = {-0.25,0.5},
	},
	beep1 =
	{
		file = "sfx/beep1.ogg",
		pitch_range = {-0.25,0.5},
	},
	beep2 =
	{
		file = "sfx/beep2.ogg",
		pitch_range = {-0.25,0.5},
	},
	beep3 =
	{
		file = "sfx/beep3.ogg",
		pitch_range = {-0.25,0.5},
	},
	rule =
	{
		file = "sfx/rule[1-5].ogg",
	},
	win_baba =
	{
		file = "sfx/winner2.ogg",
	},
	spit =
	{
		file = "sfx/spit.ogg",
		pitch_range = {-0.5,0.5},
	},
	appear =
	{
		file = "sfx/appear.ogg",
		pitch_range = {-0.5,0.5},
	},
	defeat =
	{
		file = "sfx/defeat.ogg",
		pitch_range = {-0.5,0.5},
	},
	guess_yes =
	{
		file = "sfx/dle_yes.ogg",
	},
	guess_maybe =
	{
		file = "sfx/dle_maybe.ogg",
	},
	guess_no =
	{
		file = "sfx/dle_no.ogg",
	},
	victory =
	{
		file = "sfx/win.ogg",
	},
	victory_poker =
	{
		file = "sfx/thaighaudio_concert-audience-applause.ogg",
	},
	loss =
	{
		file = "sfx/lose.ogg",
	},
	undo =
	{
		file = "sfx/undo[1-5].ogg",
		pitch_range = {-0.25,0.25},
	},
	combine =
	{
		file = "sfx/klonk1.ogg",
		pitch_range = {-0.25,0.25},
	},
	door_opening =
	{
		file = "sfx/pagancow_dorm-door-opening.ogg",
		pitch_range = {-0.2,0.2},
	},
	door_closing =
	{
		file = "sfx/pagancow_dorm-door-locked.ogg",
		pitch_range = {-0.2,0.2},
	},
	quant_error =
	{
		file = "sfx/quant_error.ogg",
	},
	quant_update =
	{
		file = "sfx/quant_update.ogg",
		pitch_range = {-0.4,0.4},
	},
	water =
	{
		file = "sfx/petrosilia_splashing-water[1-3].ogg",
		pitch_range = {-0.2,0.2},
	},
	
	music_theme =
	{
		file = "sfx/asm-menu.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "A Solitaire Mystery",
	},
	music_baba =
	{
		file = "sfx/asm-baba.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "Card Is Stack",
	},
	music_casino =
	{
		file = "sfx/asm-casino.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "Royal Flush Solitaire",
	},
	music_chaos =
	{
		file = "sfx/asm-chaos.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "Card Chaos",
	},
	music_conundrum =
	{
		file = "sfx/asm-conundrum.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "A Solitaire Conundrum",
	},
	music_council =
	{
		file = "sfx/asm-council.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "Council Of Secrets",
	},
	music_eldritch =
	{
		file = "sfx/asm-eldritch.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "Eldritch Invasion",
	},
	music_garden =
	{
		file = "sfx/asm-garden.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "Garden Of Hanoi",
	},
	music_mega =
	{
		file = "sfx/asm-mega.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "Megataire",
	},
	music_select =
	{
		file = "sfx/asm-select.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "A Solitaire Mystery (Menu)",
	},
	music_transmutation =
	{
		file = "sfx/asm-transmutation.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "Transmutation",
	},
	music_zach =
	{
		file = "sfx/asm-zach.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "Stacktronics",
	},
	music_solar =
	{
		file = "sfx/asm-solar.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "Solartaire",
	},
	music_murder =
	{
		file = "sfx/asm-murder.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "Murder Mystery",
	},
	music_quantum =
	{
		file = "sfx/asm-quantum.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "Tabula Rasa",
	},
	music_circuit =
	{
		file = "sfx/asm-circuit.ogg",
		tag = "music",
		type = "music",
		loop = true,
		title = "Circuit Solitaire",
	},
	music_mystery =
	{
		file = "sfx/asm-mystery.ogg",
		tag = "music",
		type = "music",
		loop = true,
	},
}

SCRIPTS = {}
VARS = 
{
	GLOBAL =
	{
		mode = 0,
		mode_timer = 0,
		reveal_timer = 0,
		victory = 0,
	},
}

SCRIPT_MODS = {"babataire","babaex","eldritch","alchemy","wolf","poker","big","lock","thing","cheat","single","binary","limited","random","swap","hanoi","fork","solitairdle","stack","tear","fiftytwo","time","garden","solar","doubleside","murder","elec","quant","key","river"}

subgames =
{
	babataire =
	{
		title = "TAP SOLITAIRE",
		title_colour = "e6a770",
		back_colour = 0x3f547c,
		desc = "A fairly traditional solitaire. The twist is that you can place up to 3 cards sideways to start new temporary stacks in order to manage things more easily.",
		rating = "***--",
		deck = "Yes",
		music = "music_baba",
		margin_colour = 0x2f4062,
	},
	babaex =
	{
		title = "BABATAIRE",
		title_colour = "e37269",
		back_colour = 0x87265a,
		desc = "Built from Tap Solitaire with the intention of trying to create a solitaire with Baba Is You -esque rule-changing gameplay.",
		rating = "**---",
		deck = "Yes",
		music = "music_baba",
		victorysound = "win_baba",
		margin_colour = 0x2a193b,
	},
	thing =
	{
		title = "UNEVEN SOLITAIRE",
		title_colour = "8faf62",
		back_colour = 0x253e2d,
		desc = "The 'uneven' part of the name comes from the fact that the rules for placement and picking of stacks are different.",
		rating = "**---",
		deck = "Yes",
		music = "music_conundrum",
		margin_colour = 0x1b2d21,
	},
	eldritch =
	{
		title = "ELDRITCH INVASION",
		title_colour = "c56f68",
		back_colour = 0x6a4d72,
		desc = "Defeat 16 eldritch monsters by matching them up with appropriate cards!",
		rating = "**---",
		deck = "Yes",
		music = "music_eldritch",
		margin_colour = 0x533b59,
	},
	cheat =
	{
		title = "CHEATDECK SOLITAIRE",
		title_colour = "e37269",
		back_colour = 0x4276a9,
		desc = "Inspired in part by a magician's deck of cards, which featured 52 copies of the 7 of diamonds. There are only 2 types of cards, and their 'values' change based on stack size.",
		rating = "****-",
		deck = "Yes; shuffle together 2 decks with one being face-up, one face-down",
		music = "music_zach",
	},
	wolf =
	{
		title = "COUNCIL OF SECRETS",
		title_colour = "e3c188",
		back_colour = 0x8c4444,
		desc = "Solve a traditional solitaire while also trying to identify 12 face cards based on their behaviour!",
		rating = "***--",
		deck = "$Cffa32aNo; the hidden information can't really be recreated in single-player format",
		music = "music_council",
		margin_colour = 0x642c2c,
	},
	lock =
	{
		title = "LOCK SOLITAIRE",
		title_colour = "57a3c9",
		back_colour = 0x4f5779,
		desc = "Every time you move a card, it gets locked in place for 2 moves.",
		rating = "**---",
		deck = "Yes",
		music = "music_zach",
		margin_colour = 0x3e4564,
	},
	poker =
	{
		title = "ROYAL FLUSH SOLITAIRE",
		title_colour = "c18962",
		back_colour = 0x523432,
		desc = "Your goal is to try to construct poker hands. Each hand gives you points based on the cards.",
		rating = "**---",
		deck = "Yes",
		music = "music_casino",
	},
	single =
	{
		title = "SINGLE-CARD SOLITAIRE",
		title_colour = "4276a9",
		back_colour = 0x4276a9,
		desc = "A continuation on Cheatdeck Solitaire, attempting to reduce the amount of different cards from 2 to 1.",
		rating = "***--",
		deck = "$Cd8d962Yes; the solitaire requires 112 cards, but any cards will do",
		music = "music_zach",
		margin_colour = 0x336393,
	},
	binary =
	{
		title = "BINARY SOLITAIRE",
		title_colour = "aaaaaa",
		back_colour = 0x808080,
		desc = "The binary counting adds a really wacky dimension to the card-combining!",
		rating = "***--",
		deck = "$Cd8d962Yes, if you can find a way to determine the card values (16 zeros, 36 ones)",
		music = "music_zach",
	},
	alchemy =
	{
		title = "TRANSMUTATION",
		title_colour = "c18962",
		back_colour = 0x523432,
		desc = "You can and must combine cards to create new ones with higher number values than what you otherwise would have available.",
		rating = "*****",
		deck = "$Cffa32aYes, but you'd need about 254 different cards",
		music = "music_transmutation",
	},
	big =
	{
		title = "MEGATAIRE",
		title_colour = "eb8ede",
		back_colour = 0x352938,
		desc = "Features 8 suits instead of the usual 4, with a relatively standard ruleset.",
		rating = "**---",
		deck = "Yes, by combining 2 decks with different enough illustrations",
		music = "music_mega",
		margin_colour = 0x261e28,
	},
	--[[
	code =
	{
		title = "ENCRYPTED",
		title_colour = "eb8ede",
		back_colour = 0x352938,
		desc = "OOO OOOOOOO OO OO O OOOOOOO O OOOO O OOOOOO O O OOO O O OOO O O",
		rating = "OOOOO",
		deck = "OO",
	},
	]]--
	limited =
	{
		title = "LIMITED SOLITAIRE",
		title_colour = "768189",
		back_colour = 0x5a6181,
		desc = "A solitaire that have very lenient stacking rule, but with cards being movable only a limited number of times to balance out the equation.",
		rating = "***--",
		deck = "$Cd8d962Yes",
		music = "music_conundrum",
		margin_colour = 0x474d6a,
	},
	random =
	{
		title = "CHAOTIC SOLITAIRE",
		title_colour = "c56f68",
		back_colour = 0x3a4262,
		desc = "A solitaire where cards jump around semi-randomly after each move.",
		rating = "***--",
		deck = "$Cffa32aNo",
		music = "music_chaos",
	},
	swap =
	{
		title = "SWAP-A-TAIRE",
		title_colour = "e3c188",
		back_colour = 0x773e2a,
		desc = "A variant of Chaotic Solitaire - every time you move a card, it swaps places with the card you moved before that.",
		rating = "****-",
		deck = "$Cd8d962Yes, but the swapping would be hard to keep track of",
		music = "music_chaos",
		margin_colour = 0x372524,
	},
	hanoi =
	{
		title = "HANOI SOLITAIRE",
		title_colour = "57a3c9",
		back_colour = 0x3f547c,
		desc = "A solitaire where you move cards and stacks around using a logic reminiscent of the classic Towers of Hanoi puzzle.",
		rating = "*----",
		deck = "Yes",
		music = "music_garden",
		margin_colour = 0x314262,
	},
	fork =
	{
		title = "FORK SOLITAIRE",
		title_colour = "57a3c9",
		back_colour = 0x4f5779,
		desc = "In this solitaire you have only two slots for your cards, but can fork card stacks to give yourself extra space for maneuvering.",
		rating = "****-",
		deck = "Yes",
		music = "music_zach",
		margin_colour = 0x404768,
	},
	solitairdle =
	{
		title = "SOLITAIRDLE",
		title_colour = "57a3c9",
		back_colour = 0x3f547c,
		desc = "Play solitaire while trying to figure out a 5-letter word using the cards to input your guesses.",
		rating = "***--",
		deck = "$Cffa32aNo",
		music = "music_zach",
		margin_colour = 0x304264,
	},
	stack =
	{
		title = "SINGLE-STACK SOLITAIRE",
		title_colour = "57a3c9",
		back_colour = 0x3f547c,
		desc = "The entire deck is in one stack, and you're tasked with putting the cards in a neat order.",
		rating = "***--",
		deck = "Yes",
		music = "music_conundrum",
		margin_colour = 0x334464,
	},
	tear =
	{
		title = "TEAR SOLITAIRE",
		title_colour = "57a3c9",
		back_colour = 0x3f547c,
		desc = "You'll need to tear cards in half in order to get through this solitaire.",
		rating = "***--",
		deck = "Yes",
		music = "music_chaos",
	},
TODO:	murder =
TODO:	{
TODO:		title = "MURDER MYSTERY",
TODO:		title_colour = "fafafa",
TODO:		back_colour = 0x080808,
TODO:		desc = "In this solitaire you'll have to solve a murder case while also stacking cards! Who's the killer, what's the killing weapon?",
TODO:		rating = "***--",
TODO:		deck = "$Cffa32aNo",
TODO:		music = "music_murder",
TODO:	},
	fiftytwo =
	{
		title = "52-CARD SOLITAIRE",
		title_colour = "57a3c9",
		back_colour = 0x3f547c,
		desc = "Try dropping the entire deck on the floor and then picking the cards up again!",
		rating = "***--",
		deck = "$Cd8d962Yes",
		music = "music_chaos",
		margin_colour = 0x3f547c,
	},
	--[[
	bandit =
	{
		title = "ONE-ARMED BANDIT SOLITAIRE",
		title_colour = "57a3c9",
		back_colour = 0x3f547c,
		desc = "Fulfill your dreams of dropping the entire deck on the floor and then picking them up again!",
		rating = "**---",
		deck = "$Cd8d962Yes...ish",
	},
	]]--
	time =
	{
		title = "TIME TRAVEL SOLITAIRE",
		title_colour = "8faf62",
		back_colour = 0x3f547c,
		desc = "Standard solitaire but you can bring cards from the future, as long as you eventually send them back to the past!",
		rating = "**---",
		deck = "$Cffa32aNo",
		music = "music_zach",
		margin_colour = 0x2d4064,
	},
	garden = 
    {
        title = "GARDEN SOLITAIRE",
        title_colour = "B0D983",
        back_colour = 0x5f8049,
        desc = "Plant and harvest vegetables in the garden, but be careful; Each type of crop has its own unique needs to grow!",
        rating = "**---",
        deck = "Yes; combine 2 decks and use the relevant cards",
		music = "music_garden",
		margin_colour = 0x639542,
    },
	--[[
    reverse = 
    {
        title = "REVERSE SOLITAIRE",
        title_colour = "19588f",
		back_colour = 0x264379,
        desc = "Solitaire, in reverse!$SDesigned and implemented by $LHazelstorm(https://hazelstorm.bandcamp.com/)",
        rating = "*****",
        deck = "Yes",
		music = "music_conundrum",
    },
	]]--
	solar = 
	{
		title = "SOLARTAIRE",
		title_colour = "ffdc7b",
		back_colour = 0x1f1c20,
		desc = "Align the planets and restore order to the solar system.)",
		rating = "*****",
		deck = "$Cffa32aNo, unless you create the cards yourself",
		music = "music_solar",
		margin_colour = 0x1f1c20,
	},
	doubleside =
    {
        title = "DOUBLE-SIDED SOLITAIRE",
        title_colour = "e6a770",
        back_colour = 0x523432,
        desc = "A smaller version of solitaire with double-sided cards.",
        rating = "*****",
        deck = "$Cffa32aNo, unless you create the cards yourself",
        music = "music_conundrum",
		-- margin_colour = 0x995454,
    },
	--[[
	melon =
	{
		title = "MELON SOLITAIRE",
		title_colour = "57a3c9",
		back_colour = 0x3f547c,
		desc = "Fulfill your dreams of dropping the entire deck on the floor and then picking them up again!",
		rating = "**---",
		deck = "$Cd8d962Yes...ish",
		music = "music_chaos",
	},
	]]--
	elec =
	{
		title = "CIRCUIT SOLITAIRE",
		title_colour = "59679f",
		back_colour = 0x394473,
		desc = "A solitaire where the cards form an electric circuit.",
		rating = "**---",
		deck = "$Cd8d962Yes, but you may want to draw on the cards.",
		music = "music_circuit",
		nohover = true,
	},
	quant =
	{
		title = "TABULA RASA SOLITAIRE",
		title_colour = "d9b882",
		back_colour = 0x20243a,
		desc = "Most cards in this solitaire start out without a suit or number. Your task is to resolve each card without running into impossibilities.",
		rating = "****-",
		deck = "$Cffa32aNo",
		music = "music_quantum",
		noundo = true,
	},
	key =
	{
		title = "LOCK-AND-KEY SOLITAIRE",
		title_colour = "43809f",
		back_colour = 0x394473,
		desc = "Most of the stacks are locked down! You'll need to unlock them by keeping cards in specified holding slots to gain access.",
		rating = "***--",
		deck = "Yes",
		music = "music_conundrum",
		-- margin_colour = 0x2a3251,
	},
	river =
	{
		title = "FERRET RABBIT CARROT",
		title_colour = "8faf62",
		back_colour = 0x394473,
		desc = "A solitaire based on the classic Wolf-Sheep-Cabbage riddle.",
		rating = "****-",
		deck = "Yes",
		music = "music_garden",
		margin_colour = 0x313753,
	},
	set =
	{
		title = "FERRET RABBIT CARROT",
		title_colour = "8faf62",
		back_colour = 0x394473,
		desc = "A solitaire based on the classic Wolf-Sheep-Cabbage riddle.",
		rating = "***--",
		deck = "Yes",
		music = "music_garden",
		margin_colour = 0x313753,
	},
}

TEXTIMAGES = 
{
	default =
	{
		file = "font",
		tilew = 5,
		tileh = 8,
		w = 3,
		h = 8,
		lookup = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9",".",",","?","!","-","'",'"',"/",":",";","(",")","^","+","_","~"},
		letters =
		{
			A = {w = 4},
			B = {w = 4},
			C = {w = 4},
			D = {w = 4},
			E = {w = 4},
			F = {w = 4},
			G = {w = 4},
			H = {w = 4},
			I = {w = 3},
			J = {w = 4},
			K = {w = 4},
			L = {w = 4},
			M = {w = 5},
			N = {w = 4},
			O = {w = 4},
			P = {w = 4},
			Q = {w = 4},
			R = {w = 4},
			S = {w = 4},
			T = {w = 5},
			U = {w = 4},
			V = {w = 4},
			W = {w = 5},
			X = {w = 5},
			Y = {w = 5},
			Z = {w = 4},
			i = {w = 1},
			l = {w = 1},
			m = {w = 5},
			w = {w = 5},
			["0"] = {w = 4},
			["1"] = {w = 4},
			["2"] = {w = 4},
			["3"] = {w = 4},
			["4"] = {w = 4},
			["5"] = {w = 4},
			["6"] = {w = 4},
			["7"] = {w = 4},
			["8"] = {w = 4},
			["9"] = {w = 4},
			["."] = {w = 1},
			[","] = {w = 2},
			["?"] = {w = 4},
			["!"] = {w = 1},
			["'"] = {w = 1},
			[":"] = {w = 1},
			[";"] = {w = 2},
			["("] = {w = 2},
			[")"] = {w = 2},
			["_"] = {w = 4},
			["~"] = {w = 5},
		}
	},
	header =
	{
		file = "font_big",
		tilew = 6,
		tileh = 12,
		w = 5,
		h = 11,
		lookup = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9",".",",","!","?",":",";",")","(","/","'",'"',"-","_","#","%","*","¨","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","+","^"},
		letters =
		{
			I = {w = 3},
			["1"] = {w = 3},
			["."] = {w = 1},
			[","] = {w = 2},
			["!"] = {w = 1},
			["'"] = {w = 1},
			[":"] = {w = 1},
			[";"] = {w = 2},
			["("] = {w = 3},
			[")"] = {w = 3},
			["-"] = {w = 3},
			['"'] = {w = 3},
			["f"] = {w = 4},
			["g"] = {h = 12},
			["i"] = {w = 1},
			["j"] = {w = 3, h = 12},
			["l"] = {w = 1},
			["p"] = {h = 12},
			["q"] = {h = 12},
			["r"] = {w = 4},
			["y"] = {h = 12},
		}
	},
	serif =
	{
		file = "font_serif",
		tilew = 15,
		tileh = 23,
		w = 14,
		h = 22,
		lookup = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"},
		letters =
		{
			["A"] = {w = 15},
			["C"] = {w = 13},
			["H"] = {w = 15},
			["I"] = {w = 6},
			["J"] = {w = 12},
			["K"] = {w = 15},
			["L"] = {w = 15},
			["M"] = {w = 15},
			["N"] = {w = 15},
			["O"] = {w = 13},
			["P"] = {w = 13},
			["Q"] = {w = 13},
			["R"] = {w = 15},
			["S"] = {w = 13},
			["U"] = {w = 15},
			["V"] = {w = 15},
			["W"] = {w = 15},
		}
	},
	numbers =
	{
		file = "font_numbers",
		tilew = 28,
		tileh = 44,
		w = 28,
		h = 44,
		lookup = {"0","1","2","3","4","5","6","7","8","9"},
		letters =
		{
			["0"] = {w = 27},
			["1"] = {w = 16},
			["3"] = {w = 24},
			["5"] = {w = 25},
			["6"] = {w = 27},
			["8"] = {w = 24},
			["9"] = {w = 26},
		}
	},
}

AUDIOEVENTSLIST =
{
	fade = function(data)
		local audio = AUDIO[data.target]
		local tag = audio.tag
		
		local currvolume = audio.volume
		local targetvolume = data.targetvolume or 1.0
		
		local delta = data.delta or 0.1
		local delay = data.delay or 0
		
		if (delay == 0) then
			if (currvolume > targetvolume) then
				currvolume = math.max(currvolume - delta, targetvolume)
			elseif (currvolume < targetvolume) then
				currvolume = math.min(currvolume + delta, targetvolume)
			end
			
			audio.volume = currvolume
			local tagvolume = VOLUMES[tag] or 1.0
			
			if audio.object:isPlaying() then
				local vol = currvolume * tagvolume
				audio.object:setVolume(vol)
			end
			
			if (currvolume == targetvolume) then
				if (currvolume == 0) then
					audio.object:stop()
				end
				return true
			end
		else
			delay = delay - 1
			data.delay = delay
		end
	end,
	
	changetrack = function(data)
		for i,v in pairs(AUDIO) do
			if (v.tag == "music") and v.object:isPlaying() then
				audiosys.addevent(i,"fade",{targetvolume = 0, delta = 0.05})
			end
		end
		
		audiosys.play(data.target,{volume = 0})
		audiosys.addevent(data.target,"fade",{targetvolume = 1.0, delta = 0.05, delay = 18})
		
		return true
	end,
}