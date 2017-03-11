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
        
        if showAllRates {
            getAllRates(byDate: date)
        } else {
            getDollarEuroRates(byDate: date)
        }
    }
    
    // MARK: private funcs
    
    private func getAllRates(byDate date: String) {
        RateManager.shared.getRates(forDate: date, successHandler: { [weak weakSelf = self] (rates) in
            DispatchQueue.main.async {
                weakSelf?.rates = rates
                weakSelf?.tableView.reloadData()
            }
            }, failHandler: { (error) in
                print(error)
        })
    }
    
    private func getDollarEuroRates(byDate date: String){
        RateManager.shared.getDollarAndEuroRates(forDate: date, successHandler: { [weak weakSelf = self] (rates) in
            DispatchQueue.main.async {
                weakSelf?.rates = rates
                weakSelf?.tableView.reloadData()
            }
            }, failHandler: { (error ) in
                print(error)
        })
    }
}
