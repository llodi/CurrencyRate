//
//  ViewController.swift
//  CurrencyRate
//
//  Created by Ilya Dolgopolov on 10.03.17.
//  Copyright © 2017 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class CRPickerDateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    struct Constants {
        static let ShowRatesOnDateSegue = "showRates"
        static let NavTitle = "Курс валют"
    }
    
    var dates = [String]()
    
    @IBOutlet weak var datePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Constants.NavTitle
        
        datePickerView.delegate = self
        datePickerView.dataSource = self
        
        if let dts = DateHelper.getDates() {
            dates = dts
        }
    }
    
    
    // MARK: UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dates.count
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return dates[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        performSegue(withIdentifier: Constants.ShowRatesOnDateSegue, sender: dates[row])
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.ShowRatesOnDateSegue {
            if let date = sender as? String {
                if let rvc = segue.destination as? CRBaseRatesOnDateViewController {
                    rvc.currentDate = date
                }
            }
        }
    }
}

