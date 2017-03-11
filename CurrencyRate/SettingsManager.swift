//
//  SettingsManager.swift
//  CurrencyRate
//
//  Created by Ilya Dolgopolov on 11.03.17.
//  Copyright © 2017 Ilya Dolgopolov. All rights reserved.
//

import Foundation



class SettingsManager {
    
    static let shared = SettingsManager()
    
    private let userDefailts = UserDefaults.standard
    
    func saveShowAllRatesSwither(state switcherState: Bool) {
        userDefailts.set(switcherState, forKey: AppConstants.CRUserDefaultsShowAllRates)
        userDefailts.synchronize()
    }
    
    var allRatesSwitherState: Bool {
        return userDefailts.bool(forKey: AppConstants.CRUserDefaultsShowAllRates)
    }
}
