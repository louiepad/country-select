//
//  GETAllCountries.swift
//  country-select
//
//  Created by Louise Padilla on 1/16/22.
//

import Foundation
import Alamofire

class GETAllCountries {
    
    func fetchCountries(completion: @escaping ([Country]) -> Void) {
        let endpoint = "https://restcountries.com/v3.1/all"
        
        AF.request(endpoint, method: .get).responseJSON { response in
            guard let itemsData = response.data else { return }
            
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode([Country].self, from: itemsData)
                DispatchQueue.main.async {
                    completion(items)
                }
            }
            catch {
                // Do some error handling
            }
        }
    }
}
