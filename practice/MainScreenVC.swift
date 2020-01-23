//
//  ViewController.swift
//  practice
//
//  Created by Mikhail Barinov on 23.01.2020.
//  Copyright © 2020 Mikhail Barinov. All rights reserved.
//

import UIKit

class MainScreenVC: UIViewController {
    @IBOutlet weak var userNumberTextField: UITextField!
    @IBOutlet weak var checkResultLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var checksCountLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    
    var a = 0;
    var b = 0;
    
    @IBAction func actionButtonAction(_ sender: Any) {
        checkAndUpdateUI()
    }
    
    @IBAction func settingsButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SettingsVC")
        self.present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionButton.layer.cornerRadius = 10.0
        actionButton.layer.borderWidth = 1.0
        settingsButton.layer.cornerRadius = 10.0
        settingsButton.layer.borderWidth = 1.0
        settingsButton.setTitle(NSLocalizedString("SETTINGS", comment: ""), for: .normal)
        resetGame()
        userNumberTextField.text = UserDefaults.standard.string(forKey: "USER_VALUE")
        checkAndUpdateUI()
    }
    
    private func checkAndUpdateUI() {
        if (actionButton.title(for: .normal) == NSLocalizedString("CHECK_MESSAGE", comment: "")) {
            guard userNumberTextField.text != "" else {
                checkResultLabel.text = NSLocalizedString("EMPTY_FIELD_MESSAGE", comment: "")
                checkResultLabel.textColor = UIColor.black
                return
            }
            
            if let userText = userNumberTextField.text, let userNumber = Int(userText) {
                b = userNumber;
            }
            
            if (a < b) {
                checkResultLabel.text = NSLocalizedString("MANY_MESSAGE", comment: "")
                checkResultLabel.textColor = UIColor.red
                actionButton.setTitle(NSLocalizedString("CHECK_MESSAGE", comment: ""), for: .normal)
            } else if (a > b) {
                checkResultLabel.text = NSLocalizedString("FEW_MESSAGE", comment: "")
                checkResultLabel.textColor = UIColor.red
                actionButton.setTitle(NSLocalizedString("CHECK_MESSAGE", comment: ""), for: .normal)
            } else {
                checkResultLabel.text = NSLocalizedString("RIGHT_MESSAGE", comment: "")
                checkResultLabel.textColor = UIColor.green
                userNumberTextField.isUserInteractionEnabled = false
                actionButton.setTitle(NSLocalizedString("AGAIN_MESSAGE", comment: ""), for: .normal)
            }
            
            let checksCount = UserDefaults.standard.integer(forKey: "CHECKS_COUNT") + 1
            UserDefaults.standard.set(checksCount, forKey: "CHECKS_COUNT")
            checksCountLabel.text = NSLocalizedString("CHECKS_COUNT_TITLE_MESSAGE", comment: "") + String(checksCount)
        } else {
            resetGame()
        }
    }
    
    private func resetGame() {
        let defaults = UserDefaults.standard
        
        var minValue = 0
        var maxValue = 100
        if UserDefaults.standard.object(forKey: "MIN_VALUE") != nil {
            minValue = defaults.integer(forKey: "MIN_VALUE")
            maxValue = defaults.integer(forKey: "MAX_VALUE")
        } else {
            defaults.set(minValue, forKey: "MIN_VALUE")
            defaults.set(maxValue, forKey: "MAX_VALUE")
        }
        a = Int.random(in: minValue...maxValue)
        userNumberTextField.text = ""
        userNumberTextField.isUserInteractionEnabled = true
        checkResultLabel.text = NSLocalizedString("EMPTY_FIELD_MESSAGE", comment: "")
        checkResultLabel.textColor = UIColor.black
        actionButton.setTitle(NSLocalizedString("CHECK_MESSAGE", comment: ""), for: .normal)
        UserDefaults.standard.set(0, forKey: "CHECKS_COUNT")
        checksCountLabel.text = NSLocalizedString("CHECKS_COUNT_TITLE_MESSAGE", comment: "") + String(UserDefaults.standard.string(forKey: "CHECKS_COUNT")!)
    }
    
    @IBAction func userNumberChangedAction(_ sender: Any) {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        if let userText = userNumberTextField.text {
            let compSepByCharInSet = userText.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            userNumberTextField.text = numberFiltered
            UserDefaults.standard.set(userNumberTextField.text, forKey: "USER_VALUE")
        }
    }
}

