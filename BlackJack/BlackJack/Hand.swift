//
//  Hand.swift
//  BlackJack
//
//  Created by Rean on 2/28/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import Foundation

class Hand{
    var cards:[Card]
    var sum:Int
    var bet:Int
    var containAce: Bool
    var aceCounted: Bool
    var isBS: Bool
    var isBJ: Bool
    
    init(){
        cards = []
        sum = 0
        bet = 1
        containAce = false
        aceCounted = false
        isBS = false
        isBJ = false
    }
    
}