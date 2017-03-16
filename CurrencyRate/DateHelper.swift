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
            dates.append(date.shortDateToString)
            date = calendar.date(byAdding: .day, value: -1, to: date)!
        }
        
        return dates
    }
    
    class func getDatesByOneToBackwarDirection(for dates: [String]) -> [String] {
        
        var dts = dates
        
        guard let lastDateStr = dates.last else { return dts }
        guard let lastDate = lastDateStr.shortDateFromString else { return dts }
        
        let calendar = Calendar.current
        
        let date = calendar.startOfDay(for: lastDate)
        
        if let dt = calendar.date(byAdding: .day, value: -1, to: date) {
            dts.append(dt.shortDateToString)
        }
        
        return dts
    }
    
    class func getDatesByOneToForwardDirection(for dates: [String]) -> [String] {
        
        var dts = dates
        
        guard let firstDateStr = dates.first else { return dts }
        guard let firstDate = firstDateStr.shortDateFromString else { return dts }
        
        if firstDate.shortDate == Date().shortDate { return dts}
        
        let calendar = Calendar.current
        
        let date = calendar.startOfDay(for: firstDate)
        
        if let dt = calendar.date(byAdding: .day, value: 1, to: date) {
            dts.insert(dt.shortDateToString, at: 0)
        }
        
        return dts
    }
    
    
    class func initFromFirstDate(datesArray dates: [String]) -> [String] {
        
        guard let first = dates.first else { return dates }
        if first == Date().shortDateToString { return dates}
        
        var dts = [String]()
        dts.insert(first, at: 0)
        return dts
    }
    
    class func initFromLastDate(datesArray dates: [String]) -> [String] {
        guard let last = dates.last else { return dates }
        var dts = [String]()
        dts.append(last)
        return dts
        
    }
}

