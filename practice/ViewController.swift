//
//  ViewController.swift
//  practice
//
//  Created by Mikhail Barinov on 23.01.2020.
//  Copyright © 2020 Mikhail Barinov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userNumberTextField: UITextField!
    @IBOutlet weak var checkResultLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var a = 0;
    var b = 0;
    
    let manyMessage = "Too many"
    let fewMessage = "Too few"
    let rightMessage = "Guessed right"
    let emptyFieldMessage = "Enter value"
    let buttonCheckTitle = "Check"
    let buttonResetTitle = "Again"
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        if (actionButton.title(for: .normal) == buttonCheckTitle) {
            guard userNumberTextField.text != "" else {
                checkResultLabel.text = emptyFieldMessage
                checkResultLabel.textColor = UIColor.black
                return
            }
            
            if let userText = userNumberTextField.text, let userNumber = Int(userText) {
                b = userNumber;
            }
            
            if (a < b) {
                checkResultLabel.text = manyMessage
                checkResultLabel.textColor = UIColor.red
                actionButton.setTitle(buttonCheckTitle, for: .normal)
            } else if (a > b) {
                checkResultLabel.text = fewMessage
                checkResultLabel.textColor = UIColor.red
                actionButton.setTitle(buttonCheckTitle, for: .normal)
            } else {
                checkResultLabel.text = rightMessage
                checkResultLabel.textColor = UIColor.green
                userNumberTextField.isUserInteractionEnabled = false
                actionButton.setTitle(buttonResetTitle, for: .normal)
            }
        } else {
            resetGame()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionButton.layer.cornerRadius = 10.0
        actionButton.layer.borderWidth = 1.0
        resetGame()
    }
    
    private func resetGame() {
        a = Int.random(in: 0...100)
        userNumberTextField.text = ""
        userNumberTextField.isUserInteractionEnabled = true
        checkResultLabel.text = emptyFieldMessage
        checkResultLabel.textColor = UIColor.black
        actionButton.setTitle(buttonCheckTitle, for: .normal)
    }
    
    @IBAction func userNumberChangedAction(_ sender: Any) {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        if let userText = userNumberTextField.text {
            let compSepByCharInSet = userText.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            userNumberTextField.text = numberFiltered
        }
    }
}

