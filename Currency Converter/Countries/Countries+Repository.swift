//
//  Countries+Repository.swift
//  Currency Converter
//
//  Created by Hesham Donia on 1/8/20.
//  Copyright © 2020 Dinnova. All rights reserved.
//

import Foundation
import RxSwift

protocol CountriesRepository {
    func getCountries()  -> Observable<[Country]>
}

class CountriesRepositoryImpl: CountriesRepository {
    
    let importCountriesFromFile: ImportCountriesFromFile!
    
    init(importCountriesFromFile: ImportCountriesFromFile) {
        self.importCountriesFromFile = importCountriesFromFile
    }
    
    func getCountries() -> Observable<[Country]> {
        return importCountriesFromFile.importJson()
    }
}
