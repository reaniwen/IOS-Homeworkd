//
//  Card.swift
//  Homework3
//
//  Created by Rean on 3/28/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import Foundation

enum Rank: Int {
    
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    
    func simpleDescription() -> String {
        switch self {
//        case .Ace:
//            return "A"//"ace"
        case .Jack:
            return "J"//"jack"
        case .Queen:
            return "Q"//"queen"
        case .King:
            return "K"//"king"
        default:
            return String(self.rawValue)
        }
    }
}

enum Suit: Int{
    case Spades = 1
    case Hearts, Diamonds, Clubs
    
    func simpleDescription() -> String {
        switch self{
        case .Spades: return "Spades"//return "♠"
        case .Hearts: return "Hearts"//return "♥"
        case .Diamonds: return "Diamonds"//return "♦"
        case .Clubs: return "Clubs"//"♣"
        }
    }
}

struct Card {
    var rank: Rank
    var suit: Suit
    
    //    init(rank: Rank, suit: Suit){
    //        self.rank = rank
    //        self.suit = suit
    //    }
    
    func simpleDescription() -> String {
        return "\(suit.simpleDescription())\(rank.simpleDescription())"
    }
    
}