//
//  Country.swift
//  country-select
//
//  Created by Louise Padilla on 1/16/22.
//

import Foundation

struct Name: Codable {
    let common, official: String
}

struct Flag: Codable {
    let png, svg: String
}

struct Maps: Codable {
    let googleMaps, openStreetMaps: String
}

struct Country:  Codable {
    let name: Name?
    let capital: [String]?
    let region: String?
    let subRegion: String?
    let area: Double?
    let maps: Maps?
    let population: Double?
    let timezones: [String]?
    let flags: Flag?
    
    enum CodingKeys: String, CodingKey {
        case name
        case capital
        case region
        case subRegion = "subregion"
        case area
        case maps
        case population
        case timezones
        case flags
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = container.decodeSafely(.name)
        self.capital = container.decodeSafely(.capital)
        self.region = container.decodeSafely(.region)
        self.subRegion = container.decodeSafely(.subRegion)
        self.area = container.decodeSafely(.area)
        self.maps = container.decodeSafely(.maps)
        self.population = container.decodeSafely(.population)
        self.timezones = container.decodeSafely(.timezones)
        self.flags = container.decodeSafely(.flags)
    }
}


