//
//  Shoe.swift
//  BlackJack
//
//  Created by Rean on 2/28/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import Foundation

struct Shoe {
    var cards: [Card]
    
    init(decks:Int = 1){
        cards = []
        for deck in 0..<decks {
            let tempDeck = Deck();
            cards += tempDeck.cards
        }
    }
}