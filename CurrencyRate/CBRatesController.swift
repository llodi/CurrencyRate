//
//  CBRatesController.swift
//  CurrencyRate
//
//  Created by Ilya Dolgopolov on 11.03.17.
//  Copyright © 2017 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class CBRatesController: CRBaseRatesOnDateViewController, CRModelUpdater {
    
    var showAllRates = SettingsManager.shared.allRatesSwitherState

    override func viewDidLoad() {
        super.viewDidLoad()
        modelUpdater = self
        
        if let cDate = currentDate {
            getRates(byDate: cDate)
        }
    }
    
    // MARK: CRModelUpdater
    
    func getRates(byDate date: String) {
        
        RateManager.shared.getRates(forDate: date, successHandler: { [weak weakSelf = self] (rates) in
            
            if weakSelf?.showAllRates ?? false {
                weakSelf?.rates = rates
            } else {
                weakSelf?.rates = RateManager.shared.getDollarAndEuro(fromRates: rates)
            }
            
            DispatchQueue.main.async {
                weakSelf?.tableView.reloadData()
            }
        }, failHandler: { (error) in
            print(error)
        })
    }
    
}
