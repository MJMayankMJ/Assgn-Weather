//
//  CityWeather.swift
//  Assgn Weather
//
//  Created by Mayank Jangid on 12/24/24.
//

import Foundation

struct CityWeather: Identifiable {
    let id = UUID()
    let cityName: String
    let temperature: Double
}
