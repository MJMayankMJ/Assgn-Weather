//
//  WeatherData.swift
//  Assgn Weather
//
//  Created by Mayank Jangid on 12/24/24.
//

import Foundation


struct WeatherData: Codable, Identifiable{
    let id : UUID
    let temperature: Double
    let date: String
}
