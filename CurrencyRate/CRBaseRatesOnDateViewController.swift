//
//  CRBaseRatesOnDateViewController.swift
//  CurrencyRate
//
//  Created by Ilya Dolgopolov on 11.03.17.
//  Copyright © 2017 Ilya Dolgopolov. All rights reserved.
//

import UIKit

protocol CRModelUpdater {
    func getRates(byDate date: String)
}

class CRBaseRatesOnDateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct Constants {
        static let BaseRateCellId = "BaseRateCellId"
        static let CellEstimatedHeight: CGFloat = 44
        static let HeaderCellId = "HeaderCellId"
        static let HeaderHeight: CGFloat = 26
    }
    
    var currentDate: String?
    
    var rates: [Rate]?
    
    var modelUpdater: CRModelUpdater?
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = Constants.CellEstimatedHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        navigationItem.title = currentDate == nil ? "" : "Курс на \(currentDate!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: UITableViewDataSource 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let rts = rates {
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.BaseRateCellId) as? BaseRateCell {
                cell.rate = rts[indexPath.item]
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    // MARK: UITableViewDelegate

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.HeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.HeaderCellId) {
            return cell
        }
        
        return nil
    }

}
