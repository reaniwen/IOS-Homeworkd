//
//  Player.swift
//  Homework3
//
//  Created by Rean on 3/28/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import Foundation

class Player{
    var hands: [Hand] = []
    var name: String = ""
    var money: Int = 100
    var shown: Bool = false
    
    init(name: String){
        hands.append(Hand())
        self.name = name
    }
    
    init(){
        hands.append(Hand())
    }
}