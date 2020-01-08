//
//  CountriesViewModel.swift
//  Currency Converter
//
//  Created by Hesham Donia on 1/8/20.
//  Copyright © 2020 Dinnova. All rights reserved.
//

import Foundation
import RxSwift

protocol CountriesViewModel {
    func getCountries()  -> Observable<[Country]>
}

class CountriesViewModelImpl: CountriesViewModel {
    
    let repository: CountriesRepository!
    
    init(repository: CountriesRepository) {
        self.repository = repository
    }
    
    func getCountries() -> Observable<[Country]> {
        return repository.getCountries()
    }
}
