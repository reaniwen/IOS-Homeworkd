//
//  ViewController.swift
//  BlackJack
//
//  Created by Rean on 2/14/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        hidButton(hit, bButton: stand, cButton: incBet, dButton: start)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func startButton(sender: UIButton) {
        hidButton(incBet, bButton: start, cButton: hit, dButton: stand)
    }
    
    @IBAction func incBetButton(sender: UIButton) {
    }
    
    @IBAction func hitButton(sender: UIButton) {
    }
    
    @IBAction func standButton(sender: UIButton) {
        hidButton(sender, bButton: hit, cButton: incBet, dButton: start)
        judgeWin()
        
        let alert = UIAlertController(title: "Finished",
            message: "You win this round!", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func hidButton(aButton: UIButton, bButton: UIButton, cButton: UIButton, dButton: UIButton){
            aButton.hidden = true
            bButton.hidden = true
            cButton.hidden = false
            dButton.hidden = false
    }
    
    func judgeWin(){
    }
}

