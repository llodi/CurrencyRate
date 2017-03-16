//
//  Extensions.swift
//  CurrencyRate
//
//  Created by Ilya on 14.03.17.
//  Copyright © 2017 Ilya Dolgopolov. All rights reserved.
//

import Foundation


extension Date {
    var shortDateToString: String {
        return dateForamtter.string(from: self)
    }
    
    var shortDate: Date? {
        return dateForamtter.date(from: self.shortDateToString)
    }
}


extension String {
    var shortDateFromString: Date? {
        return dateForamtter.date(from: self)
    }
}

let dateForamtter: DateFormatter = {
    let fmt = DateFormatter()
    fmt.dateFormat = "dd/MM/yyyy"
    return fmt
}()
