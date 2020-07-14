import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var curencySelectedLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var curencyPicker: UIPickerView!
    
    var coinManagerSetup = CoinManagerSetup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting this class as a delagte
        coinManagerSetup.delegate = self
        curencyPicker.dataSource = self
        curencyPicker.delegate = self
        
        curencyPicker.selectedRow(inComponent: 0)
        coinManagerSetup.performCoinRequest(currency: "PLN")
    }

}

//UIPicker delgate
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

//CoinManagerdelegate delegate setup
extension ViewController: CoinManagerDelegate{
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
