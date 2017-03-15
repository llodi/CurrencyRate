//
//  CRChoosingDateController.swift
//  CurrencyRate
//
//  Created by Ilya Dolgopolov on 15.03.17.
//  Copyright © 2017 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class CRChoosingDateController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct Constants {
        static let DateCellId = "DateCellId"
        static let ShowRatesOnDateSegue = "showRates"
        static let NavTitle = "Курс валют"
    }
    
    var dates = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Constants.NavTitle
        
        tableView.delegate = self
        tableView.dataSource = self
        
        dates.append(Date().shortDateToString)
    }
   
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DateCellId) {
            cell.textLabel?.text = dates[indexPath.item]
            return cell
        }
        
        return UITableViewCell()
    }
    
    // MARK: - UIScrollViewDelegate

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dates = DateHelper.getDates(for: dates)
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.ShowRatesOnDateSegue {
            if let cell = sender as? UITableViewCell {
                if let rvc = segue.destination as? CRBaseRatesOnDateViewController {
                    rvc.currentDate = cell.textLabel?.text
                }
            }
        }
    }
}
