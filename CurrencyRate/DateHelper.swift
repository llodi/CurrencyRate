//
//  DateHelper.swift
//  CurrencyRate
//
//  Created by Ilya Dolgopolov on 11.03.17.
//  Copyright © 2017 Ilya Dolgopolov. All rights reserved.
//

import Foundation


class DateHelper {
    
    class func getDates() -> [String]? {
        var dates = [String]()
        
        let calendar = Calendar.current
        var date = calendar.startOfDay(for: Date())
        
        var endDate = DateComponents()
        endDate.year = 1971
        endDate.month = 1
        endDate.day = 1
        
        guard let endDateNSDate = calendar.date(from: endDate) else { return nil }
        
        let fmt = DateFormatter()
        fmt.dateFormat = "dd/MM/yyyy"
        
        while date >= endDateNSDate {
            dates.append(fmt.string(from: date))
            date = calendar.date(byAdding: .day, value: -1, to: date)!
        }
        
        return dates
    }
    
}
