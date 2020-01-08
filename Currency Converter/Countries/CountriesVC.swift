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
import Toast

class CountriesVC: BaseVC {
    
    var viewModel: CountriesViewModel!
    var countries = [Country]()
    var converterScreenSegueId = "ConverterSegue"

    @IBOutlet weak var countriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        
        viewModel.getCountries()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] countries in
            guard let strongSelf = self else {return}
            strongSelf.countries.removeAll()
            strongSelf.countries.append(contentsOf: countries)
            strongSelf.viewModel.getCountriesRates(countries: strongSelf.countries)
                .subscribe(onNext: { [weak self] countries in
                    guard let strongSelf = self else {return}
                    strongSelf.countries.removeAll()
                    strongSelf.countries.append(contentsOf: countries)
                    strongSelf.countriesTableView.reloadData()
                }, onError: { [weak self] error in
                    self?.view.makeToast(error.localizedDescription)
                }).disposed(by: strongSelf.disposeBag)
        }, onError: { [weak self] error in
            self?.view.makeToast(error.localizedDescription)
        }).disposed(by: disposeBag)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == converterScreenSegueId {
            if let destinationVC = segue.destination as? ConverterVC, let selectedCountry = sender as? Country {
                destinationVC.convertableRate = selectedCountry.rate
                destinationVC.convertableCurrencyName = selectedCountry.currency
            }
        }
    }

    func initTableView() {
        let nib = UINib(nibName: "CountryCell", bundle: nil)
        countriesTableView.register(nib, forCellReuseIdentifier: CountryCell.identifier)
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
    }

}

extension CountriesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath) as! CountryCell
        cell.populateData(country: self.countries[indexPath.row])
        cell.addTapGesture { [weak self] _ in
            guard let strongSelf = self else {return}
            strongSelf.performSegue(withIdentifier: strongSelf.converterScreenSegueId, sender: strongSelf.countries[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Utils.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5)
    }
}

