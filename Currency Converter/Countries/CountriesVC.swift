//
//  ViewController.swift
//  Currency Converter
//
//  Created by Hesham Donia on 1/8/20.
//  Copyright © 2020 Dinnova. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CountriesVC: BaseVC {
    
    var viewModel: CountriesViewModel!
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getCountries()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] countries in
            guard let strongSelf = self else {return}
            strongSelf.countries = countries
            for country in countries {
                print(country.name)
            }
        }).disposed(by: viewDisposeBag)
    }


}

