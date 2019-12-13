# frozen_string_literal: true

# module for store application constants and some settings
module AppSettings
  CARD_SUITS = { heart: { name_full: 'черви', name: '♥' },
                 club: { name_full: 'крести', name: '♣' },
                 diamond: { name_full: 'бубны', name: '♦' },
                 spade: { name_full: 'пики', name: '♠' } }.freeze
  CARD_RANKS = { ace: { name_full: 'Туз', name: 'Т', rank: 11 },
                 king: { name_full: 'Король', name: 'К', rank: 10 },
                 queen: { name_full: 'Дама', name: 'Д', rank: 10 },
                 jack: { name_full: 'Валет', name: 'В', rank: 10 },
                 c10: { name_full: '10', name: '10', rank: 10 },
                 c9: { name_full: '9', name: '9', rank: 9 },
                 c8: { name_full: '8', name: '8', rank: 8 },
                 c7: { name_full: '7', name: '7', rank: 7 },
                 c6: { name_full: '6', name: '6', rank: 6 },
                 c5: { name_full: '5', name: '5', rank: 5 },
                 c4: { name_full: '4', name: '4', rank: 4 },
                 c3: { name_full: '3', name: '3', rank: 3 },
                 c2: { name_full: '2', name: '2', rank: 2 } }.freeze
  LIMIT_SCORE = 21
  BOUNDARY_SCORE_FOR_AUTOMOVE = 17
  ACE_CARD_SCORE_CORRECTION = 10
  PLAYER_BANK = 100
  PLAYER_BET = 10
  PLAYER_CARD_COUNT_LIMIT = 3

  SLEEP_LONG = 2
  SLEEP_SHORT = 1
end
