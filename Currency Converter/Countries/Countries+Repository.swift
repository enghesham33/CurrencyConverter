//
//  Countries+Repository.swift
//  Currency Converter
//
//  Created by Hesham Donia on 1/8/20.
//  Copyright © 2020 Dinnova. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

protocol CountriesRepository {
    func getCountries() -> Observable<[Country]>
    func getCountriesRates(symbols: String)  -> Observable<CountriesRatesResponse?>
}

class CountriesRepositoryImpl: CountriesRepository {
    
    let importCountriesFromFile: ImportCountriesFromFile!
    
    init(importCountriesFromFile: ImportCountriesFromFile) {
        self.importCountriesFromFile = importCountriesFromFile
    }
    
    func getCountries() -> Observable<[Country]> {
        return importCountriesFromFile.importJson()
    }
    
    func getCountriesRates(symbols: String) -> Observable<CountriesRatesResponse?> {
        let url = GeneralConstants.BASE_URL + "latest"
        let parameters = ["symbols": symbols, "access_key": GeneralConstants.API_ACCESS_KEY, "format" : 1] as [String : Any]
        
        return RxAlamofire.requestJSON(.get, url, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .flatMapLatest { response, json -> Observable<CountriesRatesResponse?> in
                if let countriesRatesResponseJsonObject = json as? Dictionary<String, AnyObject> {
                    let countriesRatesrReponseData = try JSONSerialization.data(withJSONObject: countriesRatesResponseJsonObject, options: .prettyPrinted)
                    let countriesRatesrReponse = try CountriesRatesResponse.decode(data: countriesRatesrReponseData)
                    return Observable.just(countriesRatesrReponse)
                }
                
                return Observable.just(nil)
        }
    }
}
