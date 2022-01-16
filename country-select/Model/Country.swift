//
//  Country.swift
//  country-select
//
//  Created by Louise Padilla on 1/16/22.
//

import Foundation

struct Name: Codable {
    var common, official: String
    
    enum CodingKeys: String, CodingKey {
        case common
        case official
    }
}

struct Flag: Codable {
    var png, svg: String
    
    enum CodingKeys: String, CodingKey {
        case png
        case svg
    }
}

struct Country:  Codable {
    var name: Name?
    var currencies: [String]?
    var capital: [String]?
    var region: String?
    var subRegion: String?
    var languages: [String]?
    var area: Double?
    var demonyms: [String]?
    var maps: [String]?
    var population: Double?
    var timezones: [String]?
    var flags: Flag?
    
    enum CodingKeys: String, CodingKey {
        case name
        case currencies
        case capital
        case region
        case subRegion = "subregion"
        case languages
        case area
        case demonyms
        case maps
        case population
        case timezones
        case flags
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


