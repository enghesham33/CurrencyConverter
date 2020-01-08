//
//  ConverterViewModel.swift
//  Currency Converter
//
//  Created by Hesham Donia on 1/8/20.
//  Copyright © 2020 Dinnova. All rights reserved.
//

import Foundation
import RxSwift

protocol ConverterViewModel {
    func calculateBaseAmount(converterRate: Double, convertableAmount: Double) -> Observable<Double>
    func calculateConvertableAmount(converterRate: Double, baseAmount: Double) -> Observable<Double>
}

class ConverterViewModelImpl: ConverterViewModel {
    func calculateBaseAmount(converterRate: Double, convertableAmount: Double) -> Observable<Double> {
        let baseAmount = convertableAmount * converterRate
        return Observable.just(baseAmount)
    }
    
    func calculateConvertableAmount(converterRate: Double, baseAmount: Double) -> Observable<Double> {
        let convertableAmount = baseAmount * converterRate
        return Observable.just(convertableAmount)
    }
}
