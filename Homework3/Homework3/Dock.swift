//
//  Dock.swift
//  Homework3
//
//  Created by Rean on 3/28/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import Foundation

class Deck {
    var cards: [Card]
    
    init(){
        cards = []
        for newRank in 1...13{
            for newSuit in 1...4{
                var card: Card = Card(rank: Rank(rawValue: newRank)!, suit: Suit(rawValue: newSuit)!)
                cards.append(card)
            }
        }
    }
}