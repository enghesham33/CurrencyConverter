//
//  Country.swift
//  Currency Converter
//
//  Created by Hesham Donia on 1/8/20.
//  Copyright © 2020 Dinnova. All rights reserved.
//

import Foundation

struct Country: Codable {
    var name: String
    var key: String
    var currency: String
    var rate: Double!
    
    static func decode(data: Data) throws -> Country? {
        do {
            let decoder = JSONDecoder()
            let country = try decoder.decode(Country.self, from: data)
            return country
        } catch let error {
            print(error)
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case key
        case currency
    }
}
