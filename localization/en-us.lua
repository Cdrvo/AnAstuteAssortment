return {
	descriptions = {
		Spectral = {
			c_asa_crystals = {
				name = "Crystals",
				text = {
					"All {C:attention}Glass Cards{} destroyed",
					"by their own effect this",
					"run are added back to deck",
				},
			},
			c_asa_altar = {
				name = "Altar",
				text = {
					"If your deck is below",
					"{C:attention}#1#{} cards, add {C:attention}#2# Stone{}",
					"Cards with random {C:attention}Seals{}",
					"to your deck",
				},
			},
			c_asa_sage = {
				name = "Sage",
				text = {
					"If your deck is below",
					"{C:attention}#1#{} cards, add {C:attention}#2#{} playing",
					"cards with random {C:attention}Editions{}",
					"to your deck",
				},
			},
			c_asa_pentagram = {
				name = "Pentagram",
				text = {
					"Destroy {C:attention}#1#{} random card",
					"in your hand and create",
					"{C:attention}#2# Gold 6{}s",
				},
			},
			c_asa_charm = {
				name = "Charm",
				text = {
					"Destroy {C:attention}#1#{} random card",
					"in your hand and create",
					"{C:attention}#2# Lucky 7{}s",
				},
			},
			c_asa_music = {
				name = "Music",
				text = {
					"Destroy {C:attention}all{} cards in",
					"your hand, and add",
					"{C:dark_edition}Foil{} or {C:dark_edition}Holographic{}",
					"to all Jokers",
				},
			},
			c_asa_voodoo_doll = {
				name = "Voodoo Doll",
				text = {
					"Create a random {C:attention}face{}",
					"{C:attention}card{} with a random",
					"{C:attention}Enhancement{}, {C:attention}Seal{}",
					"and {C:attention}Edition{}",
				},
			},
		},
		Joker = {
			--Common
			--Uncommon
			j_asa_spare_shoes = {
				name = "Spare Shoes",
				text = {
					"This Joker gains {C:chips}+#2#{} Chips",
					"if played hand contains",
					"a {C:attention}Pair{}",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
				},
			},
			j_asa_spare_dress_shirt = {
				name = "Spare Dress Shirt",
				text = {
					"This Joker gives {C:money}+$#1#{}",
					"if played hand contains a",
					"{C:attention}Three of a Kind",
				},
			},
			j_asa_rising_sun_casino = {
				name = "Rising Sun Casino",
				text = {
					"If played hand is a {C:attention}Two Pair",
					"with no {C:hears}Heart{} card,",
					"it is considered a {C:attention}Full House",
				},
			},
			j_asa_klein_bottle = {
				name = "Klein Bottle",
				text = {
					"If played hand contains a scoring",
					"leftmost {C:attention}Ace{} and a rightmost {C:attention}2",
					"all playing cards become {C:attention}Glass{}",
				},
			},
			j_asa_attorney = {
				name = "Attorney",
				text = {
					"When a hand is played",
					"{C:chips}+#2#{} Chips if there are more",
					"{C:blue}hands{} than {C:red}discards{}.",
					"{X:mult,C:white}X#1#{} Mult otherwise",
				},
			},
			j_asa_ds_al_cola = {
				name = "D.S. al Coda",
				text = {
					"This joker gains ",
					"{X:mult,C:white}X#2#{} Mult",
					"everytime a poker hand",
					"is repeated this round.",
					"has a {C:green}#3# in #4#{} Chance to",
					"{C:red}reset{} while entering a",
					"small or big blind",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
				},
			},
			j_asa_snake_eyes = {
				name = "Snake Eyes",
				text = {
					"{C:red}-#1#{} to all {C:attention}listed",
					"{C:green,E:1,S:1.1}probabilities",
					"{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}0 in 3{C:inactive})",
				},
			},
			j_asa_six_uational = {
				name = "Six-uational",
				text = {
					"Retrigger all played",
					"{C:attention}Steel{} and {C:attention}Gold{} cards",
					"or {C:attention}Other Enhancements{} held in hand {C:attention}#1#{} time",
					"If the retriggered card is a {C:attention}6{}",
					"trigger it {C:attention}1{} extra time",
				},
			},
			j_asa_power_of_seven = {
				name = "The Power of Seven",
				text = {
					"Create a {C:dark_edition}Spectral{} card",
					"for every {C:attention}7 {C:inactive}(#1#){} hands played",
					"with atleast one scoring {C:attention}7{}",
					"{C:inactive}(Must have room)",
				},
			},
			j_asa_jackpot = {
				name = "Jackpot!",
				text = {
					"Gives {C:money}+$#2#{} and",
					"{X:mult,C:white}X#1#{} Mult",
					"if played hand has atleast",
					"three scoring {C:attention}7{}s",
				},
			},
			j_asa_pocket_snowmen = {
				name = "Pocket Snowmen",
				text = {
					"This Joker gains {C:mult}+#2#{} Mult",
					"if played hand contains two",
					"or more scoring {C:attention}8{}s that",
					"are the highest scored rank",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
				},
			},
			j_asa_niner_niner = {
				name = "Niner Niner",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"if scoring hand has atleast",
					"two {C:attention}9{}s",
				},
			},
			j_asa_of_all_trades = {
				name = "Of All Trades",
				text = {"Jacks are considered",
				"as all suits",}
			},
			j_asa_halberd = {
				name = "Halberd",
				text = {"When {C:attention}Boss Blind{} is selected",
				"this joker gain {X:mult,C:white}X#2#{} Mult",
				"for every {C:attention}Jack{} in your deck",
				"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",}
			},
			j_asa_pizza = {
				name = "Pizza",
				text = {"Copies the ability",
				"of the {C:attention}Right-Most{} Joker",
                "{C:red}Self-Destructs{} after {C:attention}8{C:inactive} (#1#){} Rounds"}
			},
			--Rare
			j_asa_scrambled_eggs = {
				name = "Scrambled Eggs",
				text = {
					"{C:attention}Randomizes{} the rank and suit",
					"of all {C:attention}Playing Cards{}",
					"when sold",
				},
			},
			j_asa_bismuth = {
				name = "Bismuth",
				text = {
					"Played {C:attention}Stone Cards{}",
					"give {X:mult,C:white}X#1#{} Mult",
					"when scored",
				},
			},
			j_asa_check = {
				name = "Check",
				text = {
					"If played hand contains",
					"a {C:red}Non-Scoring{C:attention} King",
					"scored {C:attention}Queens{} give",
					"{X:mult,C:white}X#1#{} Mult",
				},
			},
			j_asa_wild_rose = {
				name = "Wild Rose",
				text = {
					"Played {C:attention}Wild Cards{}",
					"give {X:mult,C:white}X#1#{} Mult",
					"when scored.",
					"{C:attention}Wild Cards{} Cannot",
					"be debuffed",
				},
			},
		},
	},
	misc = {},
}
