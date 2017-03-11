//
//  SettingsViewController.swift
//  CurrencyRate
//
//  Created by Ilya Dolgopolov on 11.03.17.
//  Copyright © 2017 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var allRatesOutlet: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allRatesOutlet.isOn = SettingsManager.shared.allRatesSwitherState
    }
    
    @IBAction func swithAllRatesAction(_ sender: UISwitch) {
        SettingsManager.shared.saveShowAllRatesSwither(state: sender.isOn)
    }
    
}
