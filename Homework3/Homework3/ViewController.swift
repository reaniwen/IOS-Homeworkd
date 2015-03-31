//
//  ViewController.swift
//  Homework3
//
//  Created by Rean on 3/19/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var testImageview: UIImageView!
    @IBOutlet weak var poker1: UIImageView!
    
    var image = UIImage(named: "Clubs1")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testImageview.image = image
        poker1.image = image
//        self.view.addSubview(testImageview)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

