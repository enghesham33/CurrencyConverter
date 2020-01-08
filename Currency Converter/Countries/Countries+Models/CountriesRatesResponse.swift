//
//  CountriesRatesResponse.swift
//  Currency Converter
//
//  Created by Hesham Donia on 1/8/20.
//  Copyright © 2020 Dinnova. All rights reserved.
//

import Foundation

struct CountriesRatesResponse: Codable {
    var success: Bool
    var rates: Dictionary<String, Double>
    
    static func decode(data: Data) throws -> CountriesRatesResponse? {
        do {
            let decoder = JSONDecoder()
            let countriesRatesResponse = try decoder.decode(CountriesRatesResponse.self, from: data)
            return countriesRatesResponse
        } catch let error {
            print(error)
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case success
        case rates
    }
}
