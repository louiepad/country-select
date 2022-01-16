//
//  HomeViewController.swift
//  country-select
//
//  Created by Louise Padilla on 1/16/22.
//

import UIKit

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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let customCell = UINib(nibName: "CountryTableViewCell", bundle: nil)
        self.tableView.register(customCell, forCellReuseIdentifier: "CountryTableViewCell")
    }
    
    private func setupTableView() {
        
    }
    
    private func loadCountryArray() {
        request.fetchCountries { data in
            self.arrayCountries = data
            self.setupTableView()
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
            return cell
        }
        
        return UITableViewCell()
    }
}
