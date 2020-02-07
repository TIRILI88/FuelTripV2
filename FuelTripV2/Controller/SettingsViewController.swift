//
//  RouteViewController.swift
//  FuelTripV2
//
//  Created by Tim Riedesel on 2/6/20.
//  Copyright © 2020 Tim Riedesel. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var fuelPriceTextField: UITextField!
    @IBOutlet weak var milesPerGallonTextField: UITextField!
    @IBOutlet weak var gallonsPerTankTextField: UITextField!
    @IBOutlet weak var pricePerGallonLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!

    private let gasChangeNumber = ["25", "28", "29", "30", "31", "32", "33"]
    private let gasMainNumber = ["1", "2", "3", "4", "5", "6", "7"]
    var mapsManager = MapsManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        fuelPriceTextField.delegate = self
        milesPerGallonTextField.delegate = self
        gallonsPerTankTextField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        
        fuelPriceTextField.text = String(MapsManager.fuelPrice)
        milesPerGallonTextField.text = String(MapsManager.milesPerGallon)
        gallonsPerTankTextField.text = String(MapsManager.fuelInTank)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

//MARK: - UIPickerView Delegate

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return gasMainNumber.count
        }
        else {
            return gasChangeNumber.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        let gasMain = gasMainNumber[pickerView.selectedRow(inComponent: 0)]
//        let gasChange = gasChangeNumber[pickerView.selectedRow(inComponent: 1)]
//
        //pricePerGallonLabel.text = "\(gasMain).\(gasChange)"
        }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return gasMainNumber[row]
        } else {
            return gasChangeNumber[row]
        }
    }
}


//MARK: - UITextField Delegate

extension SettingsViewController: UITextFieldDelegate {
        
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.text = ""
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if milesPerGallonTextField != nil {
            MapsManager.milesPerGallon = Int(milesPerGallonTextField.text!)!
            MapsManager.fuelPrice = Double(fuelPriceTextField.text!)!
            MapsManager.fuelInTank = Int(gallonsPerTankTextField.text!)!

        }
    }
}
