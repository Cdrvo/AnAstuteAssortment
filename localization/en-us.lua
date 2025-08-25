return {
	descriptions = {
		Spectral = {
			c_asa_crystals = {
				name = "Crystals",
				text = {
					"Adds a random {C:attention}Glass Card{}",
					"to deck for every {C:attention}Glass Card{}",
					"destroyed by its own effect",
                    "{C:inactive}(Will create {C:attention}#1#{C:inactive} cards){}",
					"{C:inactive}(Resets the number of cards",
					"{C:inactive}created when used)"
				},
			},
			c_asa_altar = {
				name = "Altar",
				text = {
					"If your deck is below",
					"{C:attention}#1#{} cards, add {C:attention}Stone{}",
					"{C:attention}Cards{} with random {C:attention}Seals{}",
					"to your deck until",
					"your deck has {C:attention}#1#{} cards",
					"{C:inactive}(Will add {C:attention}#2#{C:inactive} cards){}"
				},
			},
			c_asa_sage = {
				name = "Sage",
				text = {
					"If your deck is below",
					"{C:attention}#1#{} cards, add {C:attention}playing",
					"{C:attention}cards{} with random {C:attention}Editions{}",
					"to your deck until",
					"your deck has {C:attention}#1#{} cards",
					"{C:inactive}(Will add {C:attention}#2#{C:inactive} cards){}"
				},
			},
			c_asa_pentagram = {
				name = "Pentagram",
				text = {
					"Destroy {C:attention}#1#{} random card",
					"in your hand, add",
					"{C:attention}#2# Gold 6{}s",
				},
			},
			c_asa_charm = {
				name = "Charm",
				text = {
					"Destroy {C:attention}#1#{} random card",
					"in your hand, add",
					"{C:attention}#2# Lucky 7{}s",
				},
			},
			c_asa_music = {
				name = "Music",
				text = {
					"Destroy {C:attention}all{} cards in",
					"your hand, add",
					"{C:dark_edition}Foil{} or {C:dark_edition}Holographic{}",
					"to all Jokers",
				},
			},
			c_asa_voodoo_doll = {
				name = "Voodoo Doll",
				text = {
					"Adds a random {C:attention}face{}",
					"{C:attention}card{} with a random",
					"{C:attention}Enhancement{}, {C:attention}Seal{}",
					"and {C:attention}Edition{} to deck",
				},
			},
		},
		Joker = {
			--Common
            j_asa_mobius_strip = {
                name = "Mobius Strip",
                text = {
                    "{C:attention}Straights{} can be made",
                    "with {C:attention}Aces{} in the middle",
					"{C:inactive}(ex: Q K A 2 3)"
                }
            },
            j_asa_celestial_sheet_music = {
                name = "Celestial Sheet Music",
                text = {
                    "After {C:attention}#1#{} {C:planet}Planet{} cards",
                    "are used, this Joker",
                    "levels up your {C:attention}most{}",
                    "{C:attention}played{} poker hand twice",
                    "and {C:red,E:2}self-destructs{} afterwards",
                    "{C:inactive}(Currently #2# cards used){}"
                }
            },
            j_asa_tuplets = {
                name = "Tuplets",
                text = {
                    "Each played {C:attention}3{}, {C:attention}5{}, {C:attention}6{},",
                    "{C:attention}7{}, {C:attention}9{} or {C:attention}10{} gives either",
                    "{C:chips}+#1#{} Chips, {C:mult}+#2#{} Mult",
                    "or {C:money}$#3#{} when scored"
                }
            },
            j_asa_time_sig = {
                name = "Time Signature",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "retrigger each played",
                    "{C:attention}7{} and {C:attention}4{} when scored"
                }
            },
            j_asa_measure = {
                name = "Measure",
                text = {
                    "{C:chips}+#1#{} Chips if the {C:attention}rightmost{}",
                    "played card is a scoring {C:attention}7{}"
                }
            },
            j_asa_first_dollar = {
                name = "My First Dollar",
                text = {
                    "If played hand is a",
                    "single {C:attention}Ace{}, make it a",
                    "{C:attention}Lucky Card{} and earn {C:money}$#1#{}"
                }
            },
            j_asa_indef_article = {
                name = "Indefinite Article",
                text = {
                    "If played hand contains",
                    "an unscoring {C:attention}Ace{}, then",
                    "retrigger all played",
                    "scoring cards {C:attention}#1#{}",
                    "additional time"
                }
            },
            j_asa_tenner = {
                name = "Tenner",
                text = {
                    "{C:green}#1# in #2#{} chance for played",
                    "scoring {C:attention}10{}s to give {C:money}$#3#{}",
                    "{C:green}#4# in #5#{} chance for played",
                    "scoring {C:attention}10{}s to become",
                    "{C:attention}Lucky Cards{}"
                }
            },
            j_asa_stick_shift = {
                name = "Stick Shift",
                text = {
                    "Earn {C:money}$#1#{} each time a",
                    "{C:attention}unique{} poker hand has",
                    "been played this round",
                    "Lose {C:money}$#2#{} when a {C:attention}repeat{}",
                    "hand is played this round"
                }
            },
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
					"This Joker gives {C:money}$#1#{}",
					"if played hand contains a",
					"{C:attention}Three of a Kind",
				},
			},
			j_asa_rising_sun_casino = {
				name = "Rising Sun Casino",
				text = {
					"If played hand is a {C:attention}Two Pair",
					"with no {C:hearts}Heart{} card,",
					"it is considered a {C:attention}Full House",
				},
			},
			j_asa_klein_bottle = {
				name = "Klein Bottle",
				text = {
					"If played hand contains a scoring",
					"leftmost {C:attention}Ace{} and a rightmost {C:attention}2,",
					"all cards become {C:attention}Glass{}",
					"after they score"
				},
			},
			j_asa_attorney = {
				name = "Attorney",
				text = {
					"When a hand is played,",
					"{C:chips}+#2#{} Chips if you have more",
					"{C:blue}hands{} than {C:red}discards{}",
					"Otherwise, {X:mult,C:white}X#1#{} Mult",
				},
			},
			j_asa_ds_al_cola = {
				name = "D.S. al Coda",
				text = {
					"This Joker gains {X:mult,C:white}X#2#{} Mult",
					"after playing a",
					"{C:attention}poker hand{} that has",
					"been played this round",
					"{C:red}Resets{} when entering",
					"a {C:attention}Small Blind{}",
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
					"or other {C:attention}Enhanced{} cards held in hand {C:attention}#1#{} time",
					"If the retriggered card is a {C:attention}6{},",
					"trigger it {C:attention}1{} additional time",
				},
			},
			j_asa_power_of_seven = {
				name = "The Power of Seven",
				text = {
					"Create a {C:spectral}Spectral{} card",
					"for every {C:attention}4{} hands played",
					"with at least one scoring {C:attention}7{}",
					"{C:inactive}(Must have room)",
					"{C:inactive}(Currently #1# hands left)"
				},
			},
			j_asa_jackpot = {
				name = "Jackpot!",
				text = {
					"Gives {X:mult,C:white}X#1#{} Mult",
					"if played hand has at least",
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
					"if scoring hand has at least",
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
				text = {"When {C:attention}Boss Blind{} is selected,",
				"this Joker gains {X:mult,C:white}X#2#{} Mult",
				"for every {C:attention}Jack{} in your deck",
				"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",}
			},
			j_asa_pizza = {
				name = "Pizza",
				text = {"Copies the ability",
				"of rightmost {C:attention}Joker{}",
                "{C:red}Self-destructs{} after",
				"playing {C:attention}8{} hands",
				"{C:inactive}(Currently #1# hands left)"}
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
					"a {C:red}non-scoring{C:attention} King,",
					"scored {C:attention}Queens{} give",
					"{X:mult,C:white}X#1#{} Mult",
				},
			},
			j_asa_wild_rose = {
				name = "Wild Rose",
				text = {
					"Played {C:attention}Wild Cards{}",
					"give {X:mult,C:white}X#1#{} Mult",
					"when scored",
					"{C:attention}Wild Cards{} cannot",
					"be debuffed",
				},
			},
		},
	},
	misc = {},
}
