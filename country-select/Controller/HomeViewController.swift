//
//  HomeViewController.swift
//  country-select
//
//  Created by Louise Padilla on 1/16/22.
//

import UIKit
import Progress
import UIImageView_AFNetworking_Blocks

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let request = GETAllCountries()
    var arrayCountries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        loadCountryArray()
    }

    private func setupView() {
        self.title = "Select a Country"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
    }
    
    private func setupTableView() {
        self.arrayCountries = self.arrayCountries.sorted { ($0.name?.common.lowercased())! < ($1.name?.common.lowercased())! }
        self.tableView.reloadData()
    }
    
    private func loadCountryArray() {
        Prog.start(in: self, .activityIndicator)
        request.fetchCountries { data in
            self.arrayCountries = data
            self.setupTableView()
            Prog.end(in: self)
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell") as? CountryTableViewCell {
            let countryObject = self.arrayCountries[indexPath.row]
            cell.labelName.text = countryObject.name?.common
//            cell.labelName.text = countryObject.capital?[0]
            if let imgURL = URL(string: countryObject.flags!.png) {
                cell.imgView.setImageWith(imgURL, placeholderImage: #imageLiteral(resourceName: "placeholder-image"))
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
