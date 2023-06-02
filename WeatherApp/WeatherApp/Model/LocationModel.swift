//
//  LocationModel.swift
//  WeatherApp
//
//  Created by Sanjay Adusumilli on 6/1/23.
//

import Foundation

struct LocationModel: Codable {
    let name: String
    let local_names: LocalName?
    let lat: Double?
    let lon: Double?
    let country, state: String
}

struct LocalName: Codable {
    let en: String?
}
