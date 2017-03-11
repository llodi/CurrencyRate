//
//  CBRate.swift
//  CurrencyRate
//
//  Created by Ilya Dolgopolov on 10.03.17.
//  Copyright © 2017 Ilya Dolgopolov. All rights reserved.
//

import Foundation
import SWXMLHash


protocol Rate {
    var id: String { get }
    var countryCode: String { get }
    var name: String { get }
    var nominal: Int { get }
    var value: Double { get }
}

struct CBRate: XMLIndexerDeserializable, Rate {
    var _id: String?
    var numCode: Int?
    var charCode: String?
    var _nominal: Int?
    var _name: String?
    var valueStr: String?
    
    var id: String {
        return _id ?? ""
    }
    
    var countryCode: String {
        return charCode ?? ""
    }
    
    var nominal: Int {
        return _nominal ?? 0
    }
    
    var value: Double {
        if let str = self.valueStr {
            return Double(str.replacingOccurrences(of: ",", with: ".")) ?? 0
        }
        return 0
    }
    
    var name: String {
        return _name ?? ""
    }
    
    static func deserialize(_ node: XMLIndexer) throws -> CBRate {
        return try CBRate(
            _id: node.value(ofAttribute: "ID"),
            numCode: node["NumCode"].value(),
            charCode: node["CharCode"].value(),
            _nominal: node["Nominal"].value(),
            _name: node["Name"].value(),
            valueStr: node["Value"].value()
        )
    }
}
