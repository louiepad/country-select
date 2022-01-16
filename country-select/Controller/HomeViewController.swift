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
    var tempCountry: Country?
    
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
    
    private func loadCountryArray() {
        Prog.start(in: self, .activityIndicator)
        request.fetchCountries { data in
            self.arrayCountries = data
            self.arrayCountries = self.arrayCountries.sorted { ($0.name?.common.lowercased())! < ($1.name?.common.lowercased())! }
            self.tableView.reloadData()
            Prog.end(in: self)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailVC" {
            if let navVC = segue.destination as? UINavigationController,
                let destVC = navVC.viewControllers.first as? DetailViewController {
                destVC.country = self.tempCountry
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToDetailVC", sender: nil)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell") as? CountryTableViewCell {
            let country = self.arrayCountries[indexPath.row]
            self.tempCountry = country
            cell.labelName.text = country.name?.common
            if let imgURL = URL(string: country.flags!.png) {
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
