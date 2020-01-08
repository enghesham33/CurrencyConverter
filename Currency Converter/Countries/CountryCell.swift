//
//  CountryCell.swift
//  Currency Converter
//
//  Created by Hesham Donia on 1/8/20.
//  Copyright © 2020 Dinnova. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {

     public static let identifier = "CountryCell"
    
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryRateLabel: UILabel!
        
    public func populateData(country: Country) {
        if let flagImage = UIImage(named: country.key) {
            countryFlagImageView.image = flagImage
        }
        
        countryNameLabel.text = country.name
        
        if let rate = country.rate {
            countryRateLabel.text = String(format: "%.2f", rate)
        }
    }
}
