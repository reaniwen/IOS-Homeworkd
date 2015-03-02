//
//  Singleton.swift
//  BlackJack
//
//  Created by Rean on 3/1/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import Foundation

class Singleton {
    
    var textLabel:String = "Hello John"
    var textField:String = "Hello Mary"
    
    var playerNum: Int = 0
    var deckNum: Int = 0
    
//    var player:Player = Player(name:"Tom")
    
    class var sharedInstance: Singleton {
        struct Static {
            static let instance: Singleton = Singleton()
        }
        return Static.instance
    }
    
}