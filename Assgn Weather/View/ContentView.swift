//
//  ContentView.swift
//  Assgn Weather
//
//  Created by Mayank Jangid on 12/24/24.
//


import SwiftUI


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Request Time: \(viewModel.requestTime)")
                    .padding()

                List(viewModel.cityWeather) { city in
                    NavigationLink(destination: WeeklyWeatherView(cityName: city.cityName, viewModel: viewModel)) {
                        Text("\(city.cityName): \(city.temperature)°C")
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
            }
            .onAppear {
                viewModel.fetchTimeData()
            }
            .navigationTitle("Weather App")
        }
    }
}

#Preview {
    ContentView()
}
