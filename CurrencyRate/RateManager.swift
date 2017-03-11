//
//  RateManager.swift
//  CurrencyRate
//
//  Created by Ilya Dolgopolov on 10.03.17.
//  Copyright © 2017 Ilya Dolgopolov. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash


class RateManager: NSObject {
    
    struct Constants {
        static let DateParameterKey = "date_req"
        static let DollarRateId = "R01235"
        static let EuroRateId = "R01239"
    }
    
    override init() {
        super.init()
    }
    
    static let shared = RateManager()
    
    private func getRates(withParameters parameters: [String: String], successHandler:@escaping (_ rates: [CBRate]) -> (), failHandler:@escaping (_ error: String) -> ()) {
        
        Alamofire.request(AppConstants.CRServerUrl, method: .get, parameters: parameters, encoding: URLEncoding(destination: .methodDependent)).response { response in
            
            if let data = response.data {
                let xml = SWXMLHash.parse(data)
                
                do {
                    let rates: [CBRate] = try xml["ValCurs"]["Valute"].value()
                    successHandler(rates)
                } catch let error {
                    failHandler(error.localizedDescription)
                }
            }
            failHandler(response.error.debugDescription)
        }
    }
    
    func getRates(forDate date: String, successHandler:@escaping (_ rates: [CBRate]) -> (), failHandler:@escaping (_ error: String) -> ()) {
        let parameters = [Constants.DateParameterKey: date]
        
        getRates(withParameters: parameters, successHandler: { (rates) in
            successHandler(rates)
        }, failHandler: { (error) in
            failHandler(error)
        })
    }
    
    func getDollarAndEuro(fromRates rates: [CBRate]) -> [CBRate] {
        return rates.filter({$0.id == Constants.DollarRateId || $0.id == Constants.EuroRateId})
    }
    
}
