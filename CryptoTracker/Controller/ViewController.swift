//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Pj on 13/07/2020.
//  Copyright © 2020 Pj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CoinManagerDelegate {
    
    @IBOutlet weak var curencySelectedLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var curencyPicker: UIPickerView!
    
    var coinManagerSetup = CoinManagerSetup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManagerSetup.delegate = self
        curencyPicker.dataSource = self
        curencyPicker.delegate = self
        
        
    }
    
    func didUpdateRate(rate: String, currency: String) {
        DispatchQueue.main.async {
            self.curencySelectedLabel.text = currency
            self.priceLabel.text = rate
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManagerSetup.currenciesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManagerSetup.currenciesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManagerSetup.performCoinRequest(currency: coinManagerSetup.currenciesArray[row])
    }
}
