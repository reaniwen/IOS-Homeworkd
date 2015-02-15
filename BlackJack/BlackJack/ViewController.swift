//
//  ViewController.swift
//  BlackJack
//
//  Created by Rean on 2/14/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var stockvalue: Int = 100
    var betvalue: Int = 0
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var BetLabel: UILabel!
    
    var round: Int = 0
    
    var hContainAce: Bool = false
    var pContainAce: Bool = false
    var hNotCounted: Bool = true
    var pNotCounted: Bool = true
    
    var hSumVal: Int = 0
    var pSumVal: Int = 0
    @IBOutlet weak var hSumLabel: UILabel!
    @IBOutlet weak var pSumLabel: UILabel!
    @IBOutlet weak var unknownH: UILabel!
    
    var hNext: Int = 0
    var pNext: Int = 0
    var hValue = ["","","","",""]
    var tempH2Value: String = ""
    var pValue = ["","","","",""]
    var chosen = [Int]()
    
    @IBOutlet weak var h1: UILabel!
    @IBOutlet weak var h2: UILabel!
    @IBOutlet weak var h3: UILabel!
    @IBOutlet weak var h4: UILabel!
    @IBOutlet weak var h5: UILabel!
    @IBOutlet weak var p1: UILabel!
    @IBOutlet weak var p2: UILabel!
    @IBOutlet weak var p3: UILabel!
    @IBOutlet weak var p4: UILabel!
    @IBOutlet weak var p5: UILabel!
    
    @IBOutlet weak var hit: UIButton!
    @IBOutlet weak var stand: UIButton!
    @IBOutlet weak var incBet: UIButton!
    @IBOutlet weak var start: UIButton!
    
    var cardSelected = []
    enum Rank: Int {
        
        case Ace = 1
        case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King
        
        func simpleDescription() -> String {
            switch self {
            case .Ace:
                return "ace"
            case .Jack:
                return "jack"
            case .Queen:
                return "queen"
            case .King:
                return "king"
            default:
                return String(self.rawValue)
            }
        }
    }
    
    enum Color: Int{
        case Spade = 1
        case Heart, Diamond, Club
        
        func simpleDescription() -> String {
            switch self{
            case .Spade: return "♠"
            case .Heart: return "♥"
            case .Diamond: return "♦"
            default: return "♣"
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidButton(hit, bButton: stand, cButton: incBet, dButton: start)
        initCards()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func startButton(sender: UIButton) {
        if betvalue == 0{
            let alert = UIAlertController(title: "Attention",
                message: "Please increase your bet!", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }else{
            hidButton(incBet, bButton: start, cButton: hit, dButton: stand)
            stockvalue -= betvalue
            updateLabels()
            giveTwoCards()
        }
    }
    
    @IBAction func incBetButton(sender: UIButton) {
        betvalue += 1
        updateLabels()
    }
    
    @IBAction func hitButton(sender: UIButton) {
        giveOneCard("p")
    }
    
    @IBAction func standButton(sender: UIButton) {
        judgeWin()
        hidButton(sender, bButton: hit, cButton: incBet, dButton: start)
        
        
    }
    
    func hidButton(aButton: UIButton, bButton: UIButton, cButton: UIButton, dButton: UIButton){
        aButton.hidden = true
        bButton.hidden = true
        cButton.hidden = false
        dButton.hidden = false
    }
    
    func initCards(){
        hNext = 0
        pNext = 0
        hValue = ["","","","",""]
        pValue = ["","","","",""]
        pSumVal = 0
        hSumVal = 0
        hContainAce = false
        pContainAce = false
        hNotCounted = true
        pNotCounted = true
        hSumLabel.hidden = true
        unknownH.hidden = false
    }
    
    func inside(test: Int) -> Bool{
        for val in chosen{
            if test == val{
                return true
            }
        }
        return false
    }

    func convOneCard(val: Int) -> (Int, Int){
        var color = 0
        var num = 0
        color = val / 13 + 1
        num = val % 13 + 1
        return (color,num)
    }
    
    func giveOneCard(person: Character){
        var gen: Int = Int(arc4random_uniform(52))
        var col: Int, num: Int
        var res: String
        while inside(gen){
            gen = Int(arc4random_uniform(52))
        }
        chosen.append(gen)
        (col, num) = convOneCard(gen)
        
        var numstr:String = ""
        var colstr:String = ""
        if let nume = Rank(rawValue:num){
            numstr = nume.simpleDescription()
        }
        if let cole = Color(rawValue: col){
            colstr = cole.simpleDescription()
        }
        var resstr: String
        resstr = colstr + numstr
        
        if person == "p"{
            if num == 1{
                pContainAce = true
                pSumVal += 11
            }else if num >= 10{
                pSumVal += 10
            }else{
                pSumVal += num
            }
            if pSumVal > 21{
                if pContainAce && pNotCounted {
                    pSumVal -= 10
                    pNotCounted = false
                }
            }
            pValue[pNext] = resstr
            pNext += 1
        }else{
            if num == 1{
                hContainAce = true
                hSumVal += 11
            }else if num >= 10{
                hSumVal += 10
            }else{
                hSumVal += num
            }
            if hSumVal > 21{
                if hContainAce && hNotCounted {
                    hSumVal -= 10
                    hNotCounted = false
                }
            }
            hValue[hNext] = resstr
            hNext += 1
        }
        updateLabels()
        isBust(person)
    }
    
    func isBlackJack(person: Character){
        if person == "p"{
            if pContainAce && pSumVal == 21{
                showResult(true)
            }
        }else{
            if hContainAce && hSumVal == 21{
                showResult(false)
            }
        }
    }
    
    func isBust(person: Character){
        if person == "p"{
            if pSumVal > 21{
                showResult(false)
            }
            //if player sum > 21
            //showResult(false)
        }else{
            if hSumVal > 21{
                showResult(true)
            }
            //if host sum > 21
            //showResult(true)
        }
    }
    
    func giveTwoCards(){
        giveOneCard("p")
        giveOneCard("p")
        isBlackJack("p")
        giveOneCard("h")
        giveOneCard("h")
        tempH2Value = hValue[1]
        hValue[1] = "Unknown"
        updateLabels()
        isBlackJack("h")
    }
    
    func updateLabels(){
        stockLabel.text = String(stockvalue)
        BetLabel.text = String(betvalue)
        hSumLabel.text = String(hSumVal)
        pSumLabel.text = String(pSumVal)
        h1.text = hValue[0]; h2.text = hValue[1]; h3.text = hValue[2]; h4.text = hValue[3]; h5.text = hValue[4];
        p1.text = pValue[0]; p2.text = pValue[1]; p3.text = pValue[2]; p4.text = pValue[3]; p5.text = pValue[4];
    }

    func judgeWin(){
        hSumLabel.hidden = false
        unknownH.hidden = true
        if self.hSumVal > 21{
            showResult(true)
        }
        
        hValue[1] = tempH2Value
        tempH2Value = ""
        
        while hSumVal < 16 {
            giveOneCard("h")
            hSumLabel.text = String(hSumVal)
        }
        
        if hSumVal > pSumVal{
            showResult(false)
        }else if hSumVal < pSumVal{
            showResult(true)
        }else{
            stockvalue -= betvalue
            let alert = UIAlertController(title: "Finished",
                message: "Tied!", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: { action in
                self.finishRound()
                self.initCards()
                self.betvalue = 0
                self.updateLabels()
                self.hidButton(self.hit, bButton: self.stand, cButton: self.incBet, dButton: self.start)
            })
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func showResult(res: Bool){
        var message: String
        if res{
            message = "You win this round!"
            stockvalue += (2 * betvalue)
        } else{
            message = "You lose this round!"
            stockvalue -= betvalue
        }
        let alert = UIAlertController(title: "Finished",
            message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: { action in
            self.finishRound()
            self.initCards()
            self.betvalue = 0
            self.updateLabels()
            self.hidButton(self.hit, bButton: self.stand, cButton: self.incBet, dButton: self.start)
        })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func finishRound(){
        if round <= 5{
            round += 1
        }else{
            round = 0
            chosen = []
        }
    }
        
}

