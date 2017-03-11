//
//  BaseRateCell.swift
//  CurrencyRate
//
//  Created by Ilya Dolgopolov on 11.03.17.
//  Copyright © 2017 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class BaseRateCell: UITableViewCell {
    
    
    var rate: Rate? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var nominalLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func updateUI() {
        clearUI()
        
        guard  let rt = rate else { return }
        codeLabel.text = rt.countryCode
        nominalLabel.text = "\(rt.nominal)"
        nameLabel.text = rt.name
        
        let numFormatter = NumberFormatter()
        numFormatter.maximumFractionDigits = 2
        
        valueLabel.text = String(format: "%.2f", rt.value)
    }
    
    private func clearUI() {
        codeLabel.text = ""
        nominalLabel.text = ""
        nameLabel.text = ""
        valueLabel.text = ""
    }

}
