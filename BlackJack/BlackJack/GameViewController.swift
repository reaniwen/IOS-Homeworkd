//
//  GameViewController.swift
//  BlackJack
//
//  Created by Rean on 3/2/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var hitBtn: UIButton!
    @IBOutlet weak var standBtn: UIButton!
    
    
    @IBOutlet weak var dealerSumLabel: UILabel!
    @IBOutlet weak var dealerCardsLabel: UILabel!
    
    @IBOutlet weak var p1NameLabel: UILabel!
    @IBOutlet weak var p1SumLabel: UILabel!
    @IBOutlet weak var p1MoneyLabel: UILabel!
    @IBOutlet weak var p1BetText: UITextField!
    @IBOutlet weak var p1CardsLabel: UILabel!
    
    @IBOutlet weak var p2NameLabel: UILabel!
    @IBOutlet weak var p2SumLabel: UILabel!
    @IBOutlet weak var p2MoneyLabel: UILabel!
    @IBOutlet weak var p2BetText: UITextField!
    @IBOutlet weak var p2CardsLabel: UILabel!
    
    @IBOutlet weak var p3NameLabel: UILabel!
    @IBOutlet weak var p3SumLabel: UILabel!
    @IBOutlet weak var p3MoneyLabel: UILabel!
    @IBOutlet weak var p3BetText: UITextField!
    @IBOutlet weak var p3CardsLabel: UILabel!
    
    @IBOutlet weak var p4NameLabel: UILabel!
    @IBOutlet weak var p4SumLabel: UILabel!
    @IBOutlet weak var p4MoneyLabel: UILabel!
    @IBOutlet weak var p4BetText: UITextField!
    @IBOutlet weak var p4CardsLabel: UILabel!
    
    @IBOutlet weak var p5NameLabel: UILabel!
    @IBOutlet weak var p5SumLabel: UILabel!
    @IBOutlet weak var p5MoneyLabel: UILabel!
    @IBOutlet weak var p5BetText: UITextField!
    @IBOutlet weak var p5CardsLabel: UILabel!
    
    @IBOutlet weak var p6NameLabel: UILabel!
    @IBOutlet weak var p6SumLabel: UILabel!
    @IBOutlet weak var p6MoneyLabel: UILabel!
    @IBOutlet weak var p6BetText: UITextField!
    @IBOutlet weak var p6CardsLabel: UILabel!
    
    var playersUI:[PlayerUI] = []
    
    @IBOutlet weak var currPLabel: UILabel!
    
    var sharedData:Singleton = Singleton.sharedInstance
    var playerNum: Int = 1
    var deckNum: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        playersUI.append(PlayerUI(name: p1NameLabel, sum: p1SumLabel, money: p1MoneyLabel, bet: p1BetText, cards: p1CardsLabel))
        playersUI.append(PlayerUI(name: p2NameLabel, sum: p2SumLabel, money: p2MoneyLabel, bet: p2BetText, cards: p2CardsLabel))
        playersUI.append(PlayerUI(name: p3NameLabel, sum: p3SumLabel, money: p3MoneyLabel, bet: p3BetText, cards: p3CardsLabel))
        playersUI.append(PlayerUI(name: p4NameLabel, sum: p4SumLabel, money: p4MoneyLabel, bet: p4BetText, cards: p4CardsLabel))
        playersUI.append(PlayerUI(name: p5NameLabel, sum: p5SumLabel, money: p5MoneyLabel, bet: p5BetText, cards: p5CardsLabel))
        playersUI.append(PlayerUI(name: p6NameLabel, sum: p6SumLabel, money: p6MoneyLabel, bet: p6BetText, cards: p6CardsLabel))
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func resetGameAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

class PlayerUI{
    var element = []
    var nameLabel: UILabel!
    var sumLabel: UILabel!
    var moneyLabel: UILabel!
    var betText: UITextField!
    var cardsLabel: UILabel!
    
    init(name:UILabel, sum:UILabel, money:UILabel, bet: UITextField, cards: UILabel){
        self.nameLabel = name
        self.sumLabel = sum
        self.moneyLabel = money
        self.betText = bet
        self.cardsLabel = cards
        element = [nameLabel, sumLabel, moneyLabel, betText, cardsLabel]
    }
}
