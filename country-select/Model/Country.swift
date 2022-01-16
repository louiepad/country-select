//
//  Country.swift
//  country-select
//
//  Created by Louise Padilla on 1/16/22.
//

import Foundation

struct Country:  Codable {
    let name: [String]?
    let currencies: [String]?
    let capital: [String]?
    let region: String?
    let subRegion: String?
    let languages: [String]?
    let area: Double?
    let demonyms: [String]?
    let maps: [String]?
    let population: Double?
    let timezones: [String]?
    let flags: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case currencies = "currencies"
        case capital = "capital"
        case region = "region"
        case subRegion = "subregion"
        case languages = "languages"
        case area = "area"
        case demonyms = "demonyms"
        case maps = "maps"
        case population = "population"
        case timezones = "timezones"
        case flags = "flags"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = container.decodeSafely(.name)
        self.currencies = container.decodeSafely(.currencies)
        self.capital = container.decodeSafely(.capital)
        self.region = container.decodeSafely(.region)
        self.subRegion = container.decodeSafely(.subRegion)
        self.languages = container.decodeSafely(.languages)
        self.area = container.decodeSafely(.area)
        self.demonyms = container.decodeSafely(.demonyms)
        self.maps = container.decodeSafely(.maps)
        self.population = container.decodeSafely(.population)
        self.timezones = container.decodeSafely(.timezones)
        self.flags = container.decodeSafely(.flags)
    }
}



