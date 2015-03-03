//
//  GameViewController.swift
//  BlackJack
//
//  Created by Rean on 3/2/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var testLabel: UILabel!
    
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
    
    @IBOutlet weak var restartBtn: UIButton!
    
    @IBOutlet weak var currPLabel: UILabel!
    
    var playersUI:[PlayerUI] = []
    var players:[Player] = []
    
    var dealerPlayer:Player = Player(name: "Dealer")
    
    var sharedData:Singleton = Singleton.sharedInstance
    var playerNum: Int = 1
    var deckNum: Int = 1
    var shoe: Shoe = Shoe()
    
    var currPlayer: Int = 0
    var gameRound: Int = 0
    var currPoker: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //build an array to make it convinent
        playersUI.append(PlayerUI(name: p1NameLabel, sum: p1SumLabel, money: p1MoneyLabel, bet: p1BetText, cards: p1CardsLabel, hide: true))
        playersUI.append(PlayerUI(name: p2NameLabel, sum: p2SumLabel, money: p2MoneyLabel, bet: p2BetText, cards: p2CardsLabel, hide: true))
        playersUI.append(PlayerUI(name: p3NameLabel, sum: p3SumLabel, money: p3MoneyLabel, bet: p3BetText, cards: p3CardsLabel, hide: true))
        playersUI.append(PlayerUI(name: p4NameLabel, sum: p4SumLabel, money: p4MoneyLabel, bet: p4BetText, cards: p4CardsLabel, hide: true))
        playersUI.append(PlayerUI(name: p5NameLabel, sum: p5SumLabel, money: p5MoneyLabel, bet: p5BetText, cards: p5CardsLabel, hide: true))
        playersUI.append(PlayerUI(name: p6NameLabel, sum: p6SumLabel, money: p6MoneyLabel, bet: p6BetText, cards: p6CardsLabel, hide: true))

        playerNum = sharedData.playerNum
        deckNum = sharedData.deckNum
        
        shoe = Shoe(decks: deckNum)
        shoe.cards.shuffle()
        currPoker = 0
        
        for i in 0..<playerNum{
            players.append(Player())
            playerMapping(i)
        }
        
        initGame()
        
    }
    
    func initGame(){
        testLabel.text = "\(sharedData.playerNum) + \(sharedData.deckNum)+ \(playerNum)"
        hitBtn.enabled = false
        standBtn.enabled = false
        restartBtn.hidden = true
    }
    
    func playerMapping(i: Int){
        playersUI[i].hidePlayer(false)
    }
    
    @IBAction func startAction(sender: AnyObject) {
        gameRound += 1
        hitBtn.enabled = true
        standBtn.enabled = true
        startBtn.enabled = false
        for i in 0 ..< playerNum{
            playersUI[i].betText.enabled = false
            players[i].hands[0].bet = playersUI[i].betText.text.toInt()!
            players[i].money -= players[i].hands[0].bet
            playersUI[i].moneyLabel.text = "$\(players[i].money)"
        }
        giveTwoCards()
        
    }
    
    @IBAction func hitAction(sender: AnyObject) {
        giveOneCard(currPlayer, h: 0)
    }
    
    @IBAction func standAction(sender: AnyObject) {
        nextPlayer()
        //or all stand and wait for AI move
    }

    func giveOneCard(p: Int,h: Int){
        //give one card to p
        let poker = shoe.cards[currPoker]
        players[p].hands[h].cards.append(poker)
        playersUI[p].cardsLabel.text?.extend(poker.simpleDescription())
        updateScore(p, h: h, poker: poker)
        currPoker += 1
        players[p].hands[h].isBS = isBusted(p)
        if players[p].hands[h].isBS {
            nextPlayer()
        }
    }
    
    func giveOneCardtoDealer(h: Int){
        //give one card to p
        let poker = shoe.cards[currPoker]
        dealerPlayer.hands[h].cards.append(poker)
        dealerCardsLabel.text?.extend(poker.simpleDescription())
        updateDealerScore(0,poker: poker)
        currPoker += 1
        dealerPlayer.hands[h].isBS = isDealerBusted()
//        if dealerPlayer.hands[h].isBS{
//            showResult()
//        }
    }
    
    func giveTwoCards(){
        //give two cards to dealer, only show one card
        giveOneCardtoDealer(0)
        giveOneCardtoDealer(0)
        
        //give two cards to everyplayer
        for p in 0 ..< playerNum{
            giveOneCard(p, h: 0)
            giveOneCard(p, h: 0)
        }
        currPLabel.text = "Player1"
        isBlackJack(0)
    }
    
    func nextPlayer(){
        println("\(currPlayer), \(playerNum)")
        if currPlayer < playerNum - 1{
            currPlayer += 1
            currPLabel.text = "Player\(currPlayer+1)"
            isBlackJack(currPlayer)
        }else{
            aiMove()
        }
    }
    
    func isBusted(p: Int) -> Bool{
        if players[p].hands[0].sum > 21{
            playersUI[p].sumLabel.text?.extend(" Busted!")
            return true
        }
        return false
    }
    
    func isDealerBusted() -> Bool{
        if dealerPlayer.hands[0].sum > 21{
            dealerSumLabel.text?.extend(" Busted!")
            return true
        }
        return false
    }
    
    func isBlackJack(p: Int) -> Bool{
        if players[p].hands[0].sum == 21 && players[p].hands[0].containAce {
            playersUI[p].sumLabel.text?.extend(" BJ!")
            nextPlayer()
            return true
        }
        return false
    }
    
    func updateScore(p: Int, h: Int, poker: Card){
        let rawValue = poker.rank.rawValue
        var tempSum = players[p].hands[h].sum
        if rawValue == 1{
            players[p].hands[h].containAce = true
            players[p].hands[h].aceCounted = true
            tempSum += 11
        }else if rawValue >= 10{
            tempSum += 10
        }else{
            tempSum += rawValue
        }
        if tempSum > 21{
            if players[p].hands[h].containAce && players[p].hands[h].aceCounted {
                tempSum -= 10
                players[p].hands[h].aceCounted = false
            }
        }
        players[p].hands[h].sum = tempSum
        playersUI[p].sumLabel.text = "sum: \(tempSum)"
    }
    
    func updateDealerScore(h: Int, poker: Card){
        let rawValue = poker.rank.rawValue
        var tempSum = dealerPlayer.hands[h].sum
        if rawValue == 1{
            dealerPlayer.hands[h].containAce = true
            dealerPlayer.hands[h].aceCounted = true
            tempSum += 11
        }else if rawValue >= 10{
            tempSum += 10
        }else{
            tempSum += rawValue
        }
        if tempSum > 21{
            if dealerPlayer.hands[h].containAce && dealerPlayer.hands[h].aceCounted {
                tempSum -= 10
                dealerPlayer.hands[h].aceCounted = false
            }
        }
        dealerPlayer.hands[h].sum = tempSum
        dealerSumLabel.text = "sum: \(tempSum)"
    }
    
    func aiMove(){
        hitBtn.enabled = false
        standBtn.enabled = false
        //judge blackjack
        while dealerPlayer.hands[0].sum < 16{
            giveOneCardtoDealer(0)
        }
        showResult()
    }
    
    func showResult(){
        for i in 0 ..< playerNum{
            if players[i].hands[0].isBS{
                //lose
            }else if players[i].hands[0].sum < dealerPlayer.hands[0].sum && !dealerPlayer.hands[0].isBS{
                //lose
                playersUI[i].sumLabel.text?.extend(" Lose!")
            }else if players[i].hands[0].isBJ{
                if dealerPlayer.hands[0].isBJ{
                    players[i].money += players[i].hands[0].bet
                }else{
                    players[i].money += (players[i].hands[0].bet * 2)
                    playersUI[i].moneyLabel.text = "$\(players[i].money)"
                }
            }else if dealerPlayer.hands[0].isBS{
                players[i].money += (players[i].hands[0].bet * 2)
                playersUI[i].sumLabel.text?.extend(" Win!")
                playersUI[i].moneyLabel.text = "$\(players[i].money)"
            }else if players[i].hands[0].sum > dealerPlayer.hands[0].sum && !players[i].hands[0].isBS{
                players[i].money += (players[i].hands[0].bet * 2)
                playersUI[i].sumLabel.text?.extend(" Win!")
                playersUI[i].moneyLabel.text = "$\(players[i].money)"
            }
        }
        restartBtn.hidden = false
        // start a new round
    }

    @IBAction func restartAction(sender: AnyObject) {
        restartBtn.hidden = true
        dealerPlayer.hands = [Hand()]
        dealerPlayer.money = 100
        dealerCardsLabel.text = "Cards:"
        dealerSumLabel.text = "sum:"
        for i in 0 ..< playerNum{
            players[i].hands = [Hand()]
            playersUI[i].betText.text = "1"
            playersUI[i].cardsLabel.text = "Cards:"
            playersUI[i].sumLabel.text = "sum:"
        }
        currPlayer = 0
        startBtn.enabled = true
        if gameRound == 5{
            shoe.cards.shuffle()
            currPoker = 0
        }
    }
    
    @IBAction func resetGameAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class PlayerUI{
    var nameLabel: UILabel!
    var sumLabel: UILabel!
    var moneyLabel: UILabel!
    var betText: UITextField!
    var cardsLabel: UILabel!
    
    init(name:UILabel, sum:UILabel, money:UILabel, bet: UITextField, cards: UILabel, hide: Bool){
        self.nameLabel = name
        self.sumLabel = sum
        self.moneyLabel = money
        self.betText = bet
        self.cardsLabel = cards
        self.hidePlayer(hide)
    }
    
    func hidePlayer(hide: Bool){
        nameLabel.hidden = hide
        sumLabel.hidden = hide
        moneyLabel.hidden = hide
        betText.hidden = hide
        cardsLabel.hidden = hide
    }
}
