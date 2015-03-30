//
//  StartViewController.swift
//  Homework3
//
//  Created by Rean on 3/30/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var playerPicker: UIPickerView!
    @IBOutlet weak var startButton: UIButton!
    
    let pickerData = [
        ["1","2","3","4","5","6"],
        ["1","2","3","4"],
        ["Single","Multi"]
    ]
    
    var sharedData:Singleton = Singleton.sharedInstance
    var playerNum:String = "2"
    var decks:String = "3"
    var type:String = "Single"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        playerPicker.delegate = self
        playerPicker.dataSource = self
        
        playerPicker.selectRow(1, inComponent: 0, animated: false)
        playerPicker.selectRow(2, inComponent: 1, animated: false)
        
        updateLabel()
    }
    
    func updateLabel(){
        playerNum = pickerData[0][playerPicker.selectedRowInComponent(0)]
        decks = pickerData[1][playerPicker.selectedRowInComponent(1)]
        sharedData.playerNum = playerNum.toInt()!
        sharedData.deckNum = decks.toInt()!
//        myLabel.text = "there are \(sharedData.playerNum) players and \(sharedData.deckNum) decks"
    }
    
    
    @IBAction func startAction(sender: AnyObject) {
        updateLabel()
        sharedData.textField = "hello world!"
        sharedData.playerNum = playerNum.toInt()!
        sharedData.deckNum = decks.toInt()!
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Things related to the pickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        print(pickerData.count)
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabel()
    }


}
