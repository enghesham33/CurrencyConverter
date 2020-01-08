//
//  Converter+Injection.swift
//  Currency Converter
//
//  Created by Hesham Donia on 1/8/20.
//  Copyright © 2020 Dinnova. All rights reserved.
//

import Foundation
import Swinject

extension AppDelegate {
    func assembleConverter() {
        container.register(ConverterViewModel.self) { _ in
            return ConverterViewModelImpl()
        }
        
        container.storyboardInitCompleted(ConverterVC.self) { resolver, controller in
            controller.viewModel = resolver.resolve(ConverterViewModel.self)
        }
    }
}
