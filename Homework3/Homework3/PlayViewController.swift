//
//  PlayViewController.swift
//  Homework3
//
//  Created by Rean on 3/30/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    //cards for dealer
    @IBOutlet weak var dCard1: UIImageView!
    @IBOutlet weak var dCard2: UIImageView!
    @IBOutlet weak var dCard3: UIImageView!
    @IBOutlet weak var dCard4: UIImageView!
    @IBOutlet weak var dCard5: UIImageView!
//    var dCards = [dCard1, dCard2, dCard3, dCard4, dCard5]
    //cards for player
    @IBOutlet weak var pCard1: UIImageView!
    @IBOutlet weak var pCard2: UIImageView!
    @IBOutlet weak var pCrad3: UIImageView!
    @IBOutlet weak var pCard4: UIImageView!
    @IBOutlet weak var pCard5: UIImageView!
    //cards for otherPlayer or AI
    @IBOutlet weak var aCard1: UIImageView!
    @IBOutlet weak var aCard2: UIImageView!
    @IBOutlet weak var aCard3: UIImageView!
    @IBOutlet weak var aCard4: UIImageView!
    @IBOutlet weak var aCard5: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var image = UIImage(named: "back")
        dCard1.image = image
        var height = dCard1.image?.size.height
        var width = dCard1.image?.size.width
        print("height \(height)")
        print("width \(width)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
