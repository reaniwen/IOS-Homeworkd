//
//  PlayViewController.swift
//  Homework3
//
//  Created by Rean on 3/30/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    
    @IBOutlet weak var testLabel: UILabel!
    //cards for dealer
    @IBOutlet weak var dCard1: UIImageView!
    @IBOutlet weak var dCard2: UIImageView!
    @IBOutlet weak var dCard3: UIImageView!
    @IBOutlet weak var dCard4: UIImageView!
    @IBOutlet weak var dCard5: UIImageView!
    //cards for player
    @IBOutlet weak var pCard1: UIImageView!
    @IBOutlet weak var pCard2: UIImageView!
    @IBOutlet weak var pCard3: UIImageView!
    @IBOutlet weak var pCard4: UIImageView!
    @IBOutlet weak var pCard5: UIImageView!
    //cards for otherPlayer or AI
    @IBOutlet weak var aCard1: UIImageView!
    @IBOutlet weak var aCard2: UIImageView!
    @IBOutlet weak var aCard3: UIImageView!
    @IBOutlet weak var aCard4: UIImageView!
    @IBOutlet weak var aCard5: UIImageView!
    
    @IBOutlet weak var moreBidBtn: UIButton!
    @IBOutlet weak var lessBidBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var hitBtn: UIButton!
    @IBOutlet weak var standBtn: UIButton!
    
    @IBOutlet weak var pMoneyLabel: UILabel!
    @IBOutlet weak var multiFuncLabel: UILabel!
    
    var dCards:[UIImageView] = []
    var pCards:[UIImageView] = []
    var aCards:[UIImageView] = []
    
    var sharedData:Singleton = Singleton.sharedInstance
    var deckNum: Int = 1
    
    var dealer: Player = Player()
    var player1: Player = Player()
    var player2: Player = Player()
    var players: [Player] = []
    
    var playerMoney: Int = 0
    var bidVal: Int = 1
    var dealerSum: Int = 0
    var player1Sum: Int = 0
    var player2Sum: Int = 0
    
    var shoe: Shoe = Shoe()
    var gameRound: Int = 0
    var currPoker: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deckNum = sharedData.deckNum
        
        initCards()
        
        initGame()
        generatePlayer()
        
        shoe = Shoe(decks: deckNum)
        shoe.cards.shuffle()
        currPoker = 0
        
        testImage("Spades10")
    }
    
    @IBAction func moreBidAction(sender: AnyObject) {
        bidVal += 1
        updateMultiFuncLabel("Bid: $\(bidVal)")
    }
    
    
    @IBAction func lessBidAction(sender: AnyObject) {
        if bidVal > 1{
            bidVal -= 1
        }
        updateMultiFuncLabel("Bid: $\(bidVal)")
    }
    
    @IBAction func hitAction(sender: AnyObject) {
        //give one card to player
        //give recommandation to player1
    }

    @IBAction func standAction(sender: AnyObject) {
        //if single, AI move for player2
        //if multi, wait for online move
        //dealer move
    }
    
    @IBAction func resetAction(sender: AnyObject) {
        //initCards()
        //initGame()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func startAction(sender: AnyObject) {
        hitBtn.hidden = false
        standBtn.hidden = false
        moreBidBtn.hidden = true
        lessBidBtn.hidden = true
        startBtn.hidden = true
        //add a round
        //give two cards to dealer
        giveOneCard(0); giveOneCard(0)
        //give two cards to player1
        //give two cards to player2
        //give recommandation to player1
    }
    
    func giveOneCard(p: Int){
        let poker = shoe.cards[currPoker]
        println("poker.simpleDescription\(poker.simpleDescription())")
        players[p].hand.cards.append(poker)
        if p == 0{
            updateImage(p, CardsUI: dCards)
        }else if p == 1{
            updateImage(p, CardsUI: pCards)
        }else if p == 2{
            updateImage(p, CardsUI: aCards)
        }
        //update card ui
        //updateScore
        currPoker += 1
    }
    
    func initCards(){
        dCards = [dCard1, dCard2, dCard3, dCard4, dCard5]
        pCards = [pCard1, pCard2, pCard3, pCard4, pCard5]
        aCards = [aCard1, aCard2, aCard3, aCard4, aCard5]
        for card in dCards {
            card.hidden = true
        }
        for card in pCards {
            card.hidden = true
        }
        for card in aCards {
            card.hidden = true
        }
        
        println("dCards number \(dCards.count), pCards number \(pCards.count), aCards number \(aCards.count)")
        shoe = Shoe(decks: deckNum)
        shoe.cards.shuffle()
        currPoker = 0
    }
    
    func initGame(){
        testLabel.text = "deckNum \(deckNum) with \(sharedData.playMode)"
        
        hitBtn.hidden = true
        standBtn.hidden = true
        moreBidBtn.hidden = false
        lessBidBtn.hidden = false
        startBtn.hidden = false
        updateMultiFuncLabel("Bid: $1")
    }
    
    func generatePlayer(){
        dealer = Player(type: "Dealer")
        player1 = Player(type: "Player")
        if sharedData.playMode == "Single" {
            player2 = Player(type: "Dealer")
        }else{
            player2 = Player(type: "Online")
        }
        players = [dealer, player1, player2]
    }
    
    func updateMultiFuncLabel(text: String){
        multiFuncLabel.text = text
    }
    
    func updateImage(p:Int, CardsUI:[UIImageView]){
        var count = players[p].hand.cards.count
        var cards = players[p].hand.cards
        var i = 0
        
        while i < count {
            let cardname: String = cards[i].simpleDescription()
            println("cardname \(cardname)")
            var image = UIImage(named: "\(cardname)")
            CardsUI[i].image = image
            CardsUI[i].hidden = false
            i += 1
        }
    }
    
    func testImage(name: String){
        var image = UIImage(named: name)
        aCard1.image = image
        aCard1.hidden = false
        var height = dCard1.image?.size.height
        var width = dCard1.image?.size.width
        print("height \(height)")
        println("width \(width)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
