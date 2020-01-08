//
//  ConverterVC.swift
//  Currency Converter
//
//  Created by Hesham Donia on 1/8/20.
//  Copyright © 2020 Dinnova. All rights reserved.
//

import UIKit
import RxSwift

class ConverterVC: BaseVC {
    
    
    @IBOutlet weak var baseCurrencyAmountTextField: UITextField!
    @IBOutlet weak var convertableCurrencyAmountTextField: UITextField!
    @IBOutlet weak var convertableCurrencyNameLabel: UILabel!
    
    var convertableRate: Double!
    var convertableCurrencyName: String!
    var viewModel: ConverterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        convertableCurrencyAmountTextField.text = String(convertableRate)
        convertableCurrencyNameLabel.text = convertableCurrencyName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let newBaseValueObserver = baseCurrencyAmountTextField.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .flatMapLatest { value -> Observable<Double> in
                if let doubleValue = Double(value) {
                    return .just(doubleValue)
                } else {
                    return .just(0.0)
                }
        }
        
        newBaseValueObserver.subscribe(onNext: { [weak self] newBaseValue in
            guard let strongSelf = self else {return}
            let newConvertableAmount = newBaseValue * strongSelf.convertableRate
            strongSelf.convertableCurrencyAmountTextField.text = String(format: "%.2f", newConvertableAmount)
            }, onError: { [weak self] error in
                guard let strongSelf = self else {return}
                strongSelf.view.makeToast(error.localizedDescription)
            }).disposed(by: disposeBag)
        
        let newConvertableValueObserver = convertableCurrencyAmountTextField.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .flatMapLatest { value -> Observable<Double> in
                if let doubleValue = Double(value) {
                    return .just(doubleValue)
                } else {
                    return .just(0.0)
                }
        }
        
        newConvertableValueObserver.subscribe(onNext: { [weak self] newConvertableValue in
            guard let strongSelf = self else {return}
            let newBaseAmount = newConvertableValue / strongSelf.convertableRate
            strongSelf.baseCurrencyAmountTextField.text = String(format: "%.2f", newBaseAmount)
            
            }, onError: { [weak self] error in
                guard let strongSelf = self else {return}
                strongSelf.view.makeToast(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
