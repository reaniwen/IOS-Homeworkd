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
    
    @IBOutlet weak var dealerSumLabel: UILabel!
    @IBOutlet weak var player1SumLabel: UILabel!
    @IBOutlet weak var player2SumLabel: UILabel!
    
    var dCards:[UIImageView] = []
    var pCards:[UIImageView] = []
    var aCards:[UIImageView] = []
    
    var sharedData:Singleton = Singleton.sharedInstance
    var deckNum: Int = 1
    
    var dealer: Player = Player()
    var player1: Player = Player()
    var player2: Player = Player()
    var players: [Player] = []
    
    var playersUI: [PlayerUI] = []
    
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
        
//        testImage("Spades10")
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
        giveOneCard(1)
        
        //give recommandation to player1
        //give rec
        if !isBusted(1){
            let rec = satRecommandation(1)
            if rec == "H"{
                updateMultiFuncLabel("Hit now")
            }else if rec == "S"{
                updateMultiFuncLabel("Stand now")
            }

        }
    }

    @IBAction func standAction(sender: AnyObject) {
        afterStand()
    }
    func afterStand(){
        hitBtn.hidden = true
        standBtn.hidden = true
        //if single, AI move for player2
        if sharedData.playMode ==  "Single" {
            var rec: String = satRecommandation(2)
            while rec == "H" && playersUI[2].player.hand.cards.count <= 5{
                giveOneCard(2)
                rec = satRecommandation(2)
            }
        }else {
            updateMultiFuncLabel("Waiting for the other player")
        }
        
        //dealer move
        while playersUI[0].sum < 16 && playersUI[0].player.hand.cards.count <= 5 {
            giveOneCard(0)
        }
        
        //judge win or lose
        judgeWin()
        
        moreBidBtn.hidden = false
        lessBidBtn.hidden = false
        
        //start a new round
    }
    
    @IBAction func resetAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func startAction(sender: AnyObject) {
        hitBtn.hidden = false
        standBtn.hidden = false
        moreBidBtn.hidden = true
        lessBidBtn.hidden = true
        startBtn.enabled = false
        //add a round
        //give two cards to dealer
        giveOneCard(0); giveOneCard(0)
        
        //give two cards to player1
        giveOneCard(1); giveOneCard(1)
        
        let rec = satRecommandation(1)
        if rec == "H"{
            updateMultiFuncLabel("Hit now")
        }else if rec == "S"{
            updateMultiFuncLabel("Stand now")
        }
        
        
        //give two cards to player2
        giveOneCard(2); giveOneCard(2)
        //give recommandation to player1
        if isBlackJack(1) {
            updateMultiFuncLabel("BlackJack!")
            afterStand()
        }
    }
    
    func giveOneCard(p: Int){
        let poker = shoe.cards[currPoker]
        println("poker.simpleDescription\(poker.simpleDescription())")
        playersUI[p].player.hand.cards.append(poker)
//        if playersUI[p].player.hand.cards.count == 5 {
//            hitBtn.enabled = false
//        }
        
        //update card ui image
        updateImage(p)
        
        //updateScore
        updateScore(p)
        
        if p == 1 {
            if isBusted(1) {
                afterStand()
            }
        }
        
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
        playersUI = [PlayerUI(p:dealer, cUI: dCards, sum: dealerSum), PlayerUI(p: player1, cUI: pCards, sum: player1Sum), PlayerUI(p: player2, cUI: aCards, sum: player2Sum)]
    }
    
    func updateMultiFuncLabel(text: String){
        println("The functional label will be '\(text)")
        multiFuncLabel.text = text
    }
    
    func updateImage(p:Int){
        var count = playersUI[p].player.hand.cards.count
        var cards = playersUI[p].player.hand.cards
        var i = 0
        
        while i < count {
            let cardName: String = cards[i].simpleDescription()
            var image = UIImage(named: cardName)
            playersUI[p].cardsUI[i].image = image
            playersUI[p].cardsUI[i].hidden = false
            i += 1
        }
    }
    
    func updateScore(p: Int) {
        var cards = playersUI[p].player.hand.cards
        playersUI[p].sum = 0
        for card in cards {
            var tempSum = playersUI[p].sum
            let rawValue = card.rank.rawValue
            if rawValue == 1{
                playersUI[p].player.hand.containAce = true
                playersUI[p].player.hand.aceCounted = true
                tempSum += 11
            }else if rawValue >= 10{
                tempSum += 10
            }else {
                tempSum += rawValue
            }
            if tempSum > 21 {
                if playersUI[p].player.hand.containAce && playersUI[p].player.hand.aceCounted {
                    tempSum -= 10
                    playersUI[p].player.hand.aceCounted = false
                }
            }
            playersUI[p].sum = tempSum
            println("score for \(p) is \(playersUI[p].sum)")
        }
        dealerSumLabel.text = "\(playersUI[0].sum)"
        player1SumLabel.text = "\(playersUI[1].sum)"
        player2SumLabel.text = "\(playersUI[2].sum)"
    }
    
    func isBlackJack(p: Int) -> Bool{
        let player = playersUI[p].player
        if playersUI[p].sum == 21 && player.hand.containAce {
            return true
        }else{ return false }
    }
    
    func isBusted(p: Int) -> Bool {
        let player = playersUI[p]
        if player.sum > 21 {
            updateMultiFuncLabel("Busted!")
            return true
        }else{ return false}
    }
    
    func satRecommandation(p:Int) -> String {
        //return "H" or "S" to stand for hit or stand
        var rec: String = ""
        
        let base = playersUI[0].player.hand.cards[0].rank.rawValue
        let sum = playersUI[p].sum
        if sum <= 11 {
            rec = "H"
        }else if sum >= 17 {
            rec = "S"
        }else if base == 1 || base >= 7 {
            rec = "H"
        }else {
            rec = "S"
        }
        println("Recommandation is \(rec)")

        
        return rec
    }
    
    func judgeWin(){
    
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

class PlayerUI{
    var player: Player
    var cardsUI: [UIImageView]
    var sum: Int
    
    init(p: Player, cUI:[UIImageView], sum: Int){
        player = p
        cardsUI = cUI
        self.sum = sum
    }
}
