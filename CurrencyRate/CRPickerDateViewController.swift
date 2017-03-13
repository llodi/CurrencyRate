//
//  ViewController.swift
//  CurrencyRate
//
//  Created by Ilya Dolgopolov on 10.03.17.
//  Copyright © 2017 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class CRPickerDateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate {
    
    struct Constants {
        static let ShowRatesOnDateSegue = "showRates"
        static let NavTitle = "Курс валют"
    }
    
    var dates = [String]() {
        didSet {
            datePickerView.reloadAllComponents()
        }
    }
    
    @IBOutlet weak var datePickerView: UIPickerView!
    @IBOutlet var tapGestureOutlet: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Constants.NavTitle
        
        datePickerView.delegate = self
        datePickerView.dataSource = self
        
        tapGestureOutlet.delegate = self
        tapGestureOutlet.addTarget(self, action: #selector(tappedToSelectRow(_:)))
        
        dates.append(dateForamtter.string(from: Date()))
        
    }
    
    // MARK: Actions
    
    func tappedToSelectRow(_ recognizer: UITapGestureRecognizer) {
        
        if recognizer.state == .ended {
            let rowHeight = datePickerView.rowSize(forComponent: 0).height
            
            let selectedRowFrame = datePickerView.bounds.insetBy(dx: 0, dy: (datePickerView.frame.height - rowHeight) / 2)
            
            let userTappedOnSelectedRow = selectedRowFrame.contains(recognizer.location(in: datePickerView))
            
            if userTappedOnSelectedRow {
                let selectedRow = datePickerView.selectedRow(inComponent: 0)
                performSegue(withIdentifier: Constants.ShowRatesOnDateSegue, sender: dates[selectedRow])
            }
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
        
        //if dates.count == row + 1  {
            dates = DateHelper.getDates(for: dates)
        //}
        //performSegue(withIdentifier: Constants.ShowRatesOnDateSegue, sender: dates[row])
    }

    // MARK: UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
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

