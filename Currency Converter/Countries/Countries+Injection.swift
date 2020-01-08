//
//  Countries+Injection.swift
//  Currency Converter
//
//  Created by Hesham Donia on 1/8/20.
//  Copyright © 2020 Dinnova. All rights reserved.
//

import Foundation
import Swinject

extension AppDelegate {
    
    func assembleCountries() {
        
        container.register(ImportCountriesFromFile.self) { _ in
            return ImportCountriesFromFileImpl()
        }
        
        container.register(CountriesRepository.self) { resolver in
            return CountriesRepositoryImpl(importCountriesFromFile: resolver.resolve(ImportCountriesFromFile.self)!)
        }
        
        container.register(CountriesViewModel.self) { resolver in
            return CountriesViewModelImpl(repository: resolver.resolve(CountriesRepository.self)!)
        }
        
        container.storyboardInitCompleted(CountriesVC.self) { resolver, controller in
            controller.viewModel = resolver.resolve(CountriesViewModel.self)
        }
    }
}
