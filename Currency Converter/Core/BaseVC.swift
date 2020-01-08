//
//  BaseVC.swift
//  Currency Converter
//
//  Created by Hesham Donia on 1/8/20.
//  Copyright © 2020 Dinnova. All rights reserved.
//

import Foundation
import RxSwift

class BaseVC: UIViewController {

    let disposeBag = DisposeBag()
    var viewDisposeBag: DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDisposeBag = DisposeBag()
    }
}
