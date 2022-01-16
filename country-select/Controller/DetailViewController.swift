//
//  DetailViewController.swift
//  country-select
//
//  Created by Louise Padilla on 1/16/22.
//

import UIKit
import UIImageView_AFNetworking_Blocks
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryDetailsLabel: UITextView!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupViews()
    }
    
    private func setupViews() {
        countryNameLabel.text = country?.name?.common
        
        countryDetailsLabel.text = (country?.name!.common)! + " is part of "
        
        if let region = country?.region {
            countryDetailsLabel.text.append(region + ". ")
        }
        if ((country?.capital) != nil) && (country?.capital!.count)! > 0 {
            let capital = country?.capital?[0] ?? ""
            countryDetailsLabel.text.append("The country's capital city is " + capital + ". ")
        } else {
            countryDetailsLabel.text.append((country?.name!.common)! + " does not have a capital city. ")
        }
        let area: Double = country?.area ?? 0
        countryDetailsLabel.text.append("The total land area is measured at " + formatNumber(toFormat: area) + " kilometers squared. ")
        if ((country?.timezones) != nil) && (country?.timezones!.count)! > 1 {
            let timezones = country?.timezones?.joined(separator: ", ") ?? ""
            countryDetailsLabel.text.append("They are under several timezones: " + timezones + ".")
        } else {
            let timezone = country?.timezones?[0] ?? ""
            countryDetailsLabel.text.append("It is under the " + timezone + " timezone.")
        }
        
        if let imgURL = URL(string: country?.flags?.png ?? "") {
            countryImageView.setImageWith(imgURL, placeholderImage: #imageLiteral(resourceName: "placeholder-image"))
        }
        
        let population: Double = country?.population ?? 0
        populationLabel.text = String(format: "%@ CITIZENS", formatNumber(toFormat: population))
        
        if let mapURL = URL(string: country?.maps?.googleMaps ?? "") {
            webView.load(URLRequest(url: mapURL))
        }
    }
    
    private func formatNumber(toFormat: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:toFormat)) ?? ""
        return formattedNumber
    }
}
