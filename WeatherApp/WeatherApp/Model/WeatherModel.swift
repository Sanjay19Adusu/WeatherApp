//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Sanjay Adusumilli on 6/1/23.
//

import Foundation

struct WeatherModel: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base, name: String?
    let main: Main?
    let wind: Wind?
    let clouds: Clouds?
    let sys: Sys?
    let visibility, dt, timezone, id, cod: Int?
}

struct Coord: Codable {
    let lon, lat: Double?
}

struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
}

struct Main: Codable {
    let temp, feels_like, temp_min, temp_max: Double?
    let pressure, humidity: Int?
}

struct Wind: Codable {
    let speed: Double?
    let deg: Int?
}

struct Clouds: Codable {
    let all: Int?
}

struct Sys: Codable {
    let type, id, sunrise, sunset: Int?
    let country: String?
}
