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
        ["1","2","3","4"],
        ["Single","Multi"]
    ]
    
    var sharedData:Singleton = Singleton.sharedInstance
    var decks:String = "3"
    var playMode:String = "Single"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPickerView()
        updateLabel()
    }
    
    func updateLabel(){
        decks = pickerData[0][playerPicker.selectedRowInComponent(0)]
        playMode = pickerData[1][playerPicker.selectedRowInComponent(1)]
        sharedData.deckNum = decks.toInt()!
        sharedData.playMode = playMode
        myLabel.text = "there are \(sharedData.deckNum) decks with \(sharedData.playMode) mode"
    }
    
    
    func initPickerView(){
        playerPicker.delegate = self
        playerPicker.dataSource = self
        
        //set initial position
        //select(which row, which col)
        playerPicker.selectRow(0, inComponent: 0, animated: false)
        playerPicker.selectRow(0, inComponent: 1, animated: false)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Things related to the pickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
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

extension Array{
    mutating func shuffle(){
        for i in 0..<(count-1){
            let j = Int(arc4random_uniform(UInt32(count-i))) + i
            swap(&self[i], &self[j])
        }
    }
}
