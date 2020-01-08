//
//  Countries+UseCases.swift
//  Currency Converter
//
//  Created by Hesham Donia on 1/8/20.
//  Copyright © 2020 Dinnova. All rights reserved.
//

import Foundation
import RxSwift


protocol ImportCountriesFromFile {
    func importJson() -> Observable<[Country]>
}

class ImportCountriesFromFileImpl: ImportCountriesFromFile {
    func importJson() -> Observable<[Country]> {
        
        return Observable.create({ [weak self] observer -> Disposable in
            
            if let strongSelf = self {
                do {
                    let countries = try strongSelf.loadCountriesFromFile()
                    observer.onNext(countries)
                } catch {
                    observer.onNext([])
                }
                
            } else {
                observer.onNext([])
            }
            
            return Disposables.create()
        })
        .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
    }
    
    func loadCountriesFromFile() throws -> [Country] {
        
        var countries = [Country]()
        
        if let path = Bundle.main.path(forResource: "countries_list", ofType: "json") {
           let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
           if let jsonArray = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [Dictionary<String, AnyObject>] {
               for jsonObj in jsonArray {
                   let countryData = try JSONSerialization.data(withJSONObject: jsonObj, options: .prettyPrinted)
                
                   if let country = try Country.decode(data: countryData) {
                       countries.append(country)
                   }
               }
           }
        }
        
        return countries
    }
}
