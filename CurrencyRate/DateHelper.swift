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
        
        while date >= endDateNSDate {
            dates.append(dateForamtter.string(from: date))
            date = calendar.date(byAdding: .day, value: -1, to: date)!
        }
        
        return dates
    }
    
    class func getDates(for dts: [String]) -> [String] {
        
        var dates = dts
        
        guard let lastDateStr = dates.last else { return dates }
        
        guard let lastDate = dateForamtter.date(from: lastDateStr) else { return dates }
        let calendar = Calendar.current
        
        let date = calendar.startOfDay(for: lastDate)
        
        dates.append(dateForamtter.string(from: calendar.date(byAdding: .day, value: -1, to: date)!))
        
        return dates
    }
    
}

let dateForamtter: DateFormatter = {
    let fmt = DateFormatter()
    fmt.dateFormat = "dd/MM/yyyy"
    return fmt
}()
