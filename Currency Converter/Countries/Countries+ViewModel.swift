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
    func getCountries() -> Observable<[Country]>
    func getCountriesRates(countries: [Country])  -> Observable<[Country]>
}

class CountriesViewModelImpl: CountriesViewModel {
    
    let repository: CountriesRepository!
    
    init(repository: CountriesRepository) {
        self.repository = repository
    }
    
    func getCountries() -> Observable<[Country]> {
        return repository.getCountries()
    }
    
    func getCountriesRates(countries: [Country]) -> Observable<[Country]> {
        Utils.showLoader()
        return repository.getCountriesRates(symbols: getCountriesSymbols(countries: countries))
            .flatMapLatest { [weak self] countriesRatesResponse -> Observable<[Country]> in
                Utils.hideLoader()
                guard let strongSelf = self else {return Observable.just([])}
                if let countriesRatesResponse = countriesRatesResponse {
                    return Observable.just(strongSelf.fillCountriesWithRates(countries: countries, countriesRatesResponse: countriesRatesResponse))
                } else {
                    return Observable.just([])
                }
            }
    }
    
    private func getCountriesSymbols(countries: [Country]) -> String {
        var symbols = ""
        for var index in 0...countries.count - 1 {
            if index > 0 {
                symbols = symbols + "," + countries[index].currency
            } else {
                symbols = countries[index].currency
            }
        }
        return symbols
    }
    
    private func fillCountriesWithRates(countries: [Country], countriesRatesResponse: CountriesRatesResponse) -> [Country] {
        var countriesWillBeFilledWithRates = countries
        for var index in 0...countriesWillBeFilledWithRates.count - 1 {
            let currency = countriesWillBeFilledWithRates[index].currency
            for key in countriesRatesResponse.rates.keys {
                if key == currency {
                    countriesWillBeFilledWithRates[index].rate = countriesRatesResponse.rates[key]
                    break
                }
            }
        }
        return countriesWillBeFilledWithRates
    }
}
