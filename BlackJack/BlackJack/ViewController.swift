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
    
    var hContainAce: Bool = false
    var pContainAce: Bool = false
    
    var hSumVal: Int = 0
    var pSumVal: Int = 0
    @IBOutlet weak var hSumLabel: UILabel!
    @IBOutlet weak var pSumLabel: UILabel!
    
    var hValue = [Int]()
    var pValue = [Int]()
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
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func startButton(sender: UIButton) {
        hidButton(incBet, bButton: start, cButton: hit, dButton: stand)
        giveTwoCards();
    }
    
    @IBAction func incBetButton(sender: UIButton) {
        betvalue += 1
        updateLabels()
    }
    
    @IBAction func hitButton(sender: UIButton) {
    }
    
    @IBAction func standButton(sender: UIButton) {
        hidButton(sender, bButton: hit, cButton: incBet, dButton: start)
        judgeWin()
        
        let alert = UIAlertController(title: "Finished",
            message: "You win this round!", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: { action in
            self.initCards()
            self.betvalue = 0
            self.updateLabels()
            })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func hidButton(aButton: UIButton, bButton: UIButton, cButton: UIButton, dButton: UIButton){
        aButton.hidden = true
        bButton.hidden = true
        cButton.hidden = false
        dButton.hidden = false
    }
    
    func initCards(){
        h1.hidden = true; h2.hidden = true; h3.hidden = true; h4.hidden = true; h5.hidden = true;
        p1.hidden = true; p2.hidden = true; p3.hidden = true; p4.hidden = true; p5.hidden = true;
    }
    
    func inside(test: Int) -> Bool{
        for val in chosen{
            if test == val{
                return true
            }
        }
        return false
    }
    func genOneCard() -> Int{
        var gen: Int = Int(arc4random_uniform(54))
        while inside(gen){
            gen = Int(arc4random_uniform(54))
        }
        return gen
    }
    func convOneCard(val: Int) -> (Int, Int){
        var color = 0
        var num = 0
        color = val / 13 + 1
        num = val % 13 + 1
        
        return (color,num)
    }
    
    func giveOneCard(person: Character){
        let newCard = genOneCard()
        chosen.append(newCard)
        if person == "p"{
            pValue.append(newCard)
        }else{
            hValue.append(newCard)
        }
    }
    func giveTwoCards(){
        giveOneCard("p")
        giveOneCard("p")
        giveOneCard("h")
        giveOneCard("h")
    }
    
    func updateLabels(){
        stockLabel.text = String(stockvalue)
        BetLabel.text = String(betvalue)
        hSumLabel.text = String(hSumVal)
        pSumLabel.text = String(pSumVal)
    }
    
    
    func judgeWin() -> Bool{
        if self.hSumVal > 21{
            return false
        }
        return false
    }
        
}

