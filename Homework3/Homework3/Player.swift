//
//  Player.swift
//  Homework3
//
//  Created by Rean on 3/28/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import Foundation

class Player{
    var hand: Hand = Hand()
    var name: String = ""
    var money: Int = 100
    var shown: Bool = false
    
    init(){
    
    }
    
    init(type: String){
        if type == "Dealer"{
            //generate a dealer player
        }else if type == "Player"{
            //generate a human player
        }else if type == "Online"{
            //generate a online player
        }else {
            println("generate wrong type of player, only 'Dealer', 'Player', or 'Online'")
        }
    }
}