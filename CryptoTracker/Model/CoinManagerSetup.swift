import Foundation

protocol CoinManagerDelegate {
    func didUpdateRate(rate : String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManagerSetup {
    
    let baseUrl = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "359B73B9-B7EB-448C-AE05-3E61A317A91D"
    let currenciesArray = ["PLN","USD","EUR","GBP","RUB","JPY","AUD","CRON","CHF","ZAR"]
    
    var delegate : CoinManagerDelegate?
    
    //creating url to get the json data
    func performCoinRequest(currency: String){
        
        let urlString = "\(baseUrl)/\(currency)?apikey=\(apiKey)"
        print(urlString)
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let price = self.parseJSON(safeData){
                        let priceString = String(format: "%.02f", price)
                        self.delegate?.didUpdateRate(rate: priceString, currency: currency)
                    }
                }
            }
            task.resume()
        }
        
    }
    //parsing Json data
    func parseJSON(_ data: Data) -> Double?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(CoinData.self, from: data)
            let coinRate = decodeData.rate
            print(coinRate)
            return coinRate
        }catch{
            return 0.0
        }
        
    }
}
