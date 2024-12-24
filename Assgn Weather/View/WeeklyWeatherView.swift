//
//  WeeklyWeatherView.swift
//  Assgn Weather
//
//  Created by Mayank Jangid on 12/24/24.
//

import SwiftUI

// there was soe issues regarding this so this is incomplete
struct WeeklyWeatherView: View {
    let cityName: String
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        VStack {
            Text("Weekly Weather for \(cityName)")
                .font(.headline)
                .padding()

            List(viewModel.weeklyWeather) { weather in
                Text("\(weather.date): \(weather.temperature)°C")
            }
        }
        .onAppear {
            viewModel.fetchWeeklyWeather(for: cityName)
        }
    }
}

#Preview {
    WeeklyWeatherView(cityName: "Haridwar", viewModel: WeatherViewModel())
}
