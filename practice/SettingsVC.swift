//
//  SettingsVC.swift
//  practice
//
//  Created by Mikhail Barinov on 23.01.2020.
//  Copyright © 2020 Mikhail Barinov. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var minValueLabel: UILabel!
    @IBOutlet weak var minValueTextField: UITextField!
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var maxValueTextField: UITextField!
    
    @IBAction func backButtonAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(Int(minValueTextField.text!), forKey: "MIN_VALUE")
        defaults.set(Int(minValueTextField.text!), forKey: "MIN_VALUE")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.cornerRadius = 10.0
        backButton.layer.borderWidth = 1.0
        backButton.setTitle(NSLocalizedString("BACK", comment: ""), for: .normal)
        minValueLabel.text = NSLocalizedString("MIN_VALUE_TITLE_MESSAGE", comment: "")
        maxValueLabel.text = NSLocalizedString("MAX_VALUE_TITLE_MESSAGE", comment: "")
        minValueTextField.text = String(UserDefaults.standard.integer(forKey: "MIN_VALUE"))
        maxValueTextField.text = String(UserDefaults.standard.integer(forKey: "MAX_VALUE"))
    }
    
    @IBAction func userNumberChangedAction(_ sender: Any) {
        if sender is UITextField {
            let textField = sender as! UITextField
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            if let userText = textField.text {
                let compSepByCharInSet = userText.components(separatedBy: aSet)
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                if (numberFiltered != "") {
                    textField.text = numberFiltered
                } else {
                    switch textField {
                    case minValueTextField:
                        textField.text = String(UserDefaults.standard.integer(forKey: "MIN_VALUE"))
                    case maxValueTextField:
                        textField.text = String(UserDefaults.standard.integer(forKey: "MAX_VALUE"))
                    default:
                        break
                    }
                }
            }
        }
    }
}
