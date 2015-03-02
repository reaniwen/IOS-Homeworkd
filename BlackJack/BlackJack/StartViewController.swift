//
//  StartViewController.swift
//  BlackJack
//
//  Created by Rean on 3/1/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var playerPicker: UIPickerView!
    @IBOutlet weak var startButton: UIButton!
    
    let pickerData = [
        ["1","2","3","4","5","6"],
        ["1","2","3","4"]
    ]
    
    var sharedData:Singleton = Singleton.sharedInstance
    

    override func viewDidLoad() {
        super.viewDidLoad()

        playerPicker.delegate = self
        playerPicker.dataSource = self
        
        playerPicker.selectRow(1, inComponent: 0, animated: false)
        playerPicker.selectRow(2, inComponent: 1, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateLabel(){
        let playerNum = pickerData[0][playerPicker.selectedRowInComponent(0)]
        let decks = pickerData[1][playerPicker.selectedRowInComponent(1)]
        myLabel.text = "there are " + playerNum + " players and " + decks + "decks"
    }
    
    
    @IBAction func startAction(sender: AnyObject) {
        sharedData.textField = "hello world!"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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

//get toturial at http://makeapppie.com/2014/09/18/swift-swift-implementing-picker-views/
