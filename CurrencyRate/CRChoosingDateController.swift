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

    var lastContentOffset: CGPoint = CGPoint.zero
    enum Direction {
        case up
        case down
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let visible = tableView.visibleCells
        if visible.count == 0 { return }
        
        if lastContentOffset.y < scrollView.contentOffset.y {
            //print("Scrolled Down")
            updateDataSource(withAmountCells: visible.count, withDirection: .down)
        }
        else if lastContentOffset.y > scrollView.contentOffset.y {
            //print("Scrolled Up")
            updateDataSource(withAmountCells: visible.count, withDirection: .up)
        }

    }
    
    private func updateDataSource(withAmountCells amount: Int, withDirection direction: Direction) {
        if dates.count <= amount {
            switch direction {
            case .up:
                dates = DateHelper.getDatesByOneToForwardDirection(for: dates)
            case .down:
                dates = DateHelper.getDatesByOneToBackwarDirection(for: dates)
            }
        } else if dates.count > amount {
            switch direction {
            case .up:
                dates = DateHelper.initFromFirstDate(datesArray: dates)
            case .down:
                dates = DateHelper.initFromLastDate(datesArray: dates)
            }
            
        }
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
