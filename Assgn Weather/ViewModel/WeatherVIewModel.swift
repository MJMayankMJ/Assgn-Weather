//
//  WeatherVIewModel.swift
//  Assgn Weather
//
//  Created by Mayank Jangid on 12/24/24.
//


import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
    @Published var cityWeather: [CityWeather] = []
    @Published var weeklyWeather: [WeatherData] = []
    @Published var requestTime: String = ""

    private var cancellables = Set<AnyCancellable>()
    private let apiKey = "30d9597d26f57bf9a5a6cae14591ee27" 
    func fetchTimeData() {
        let url = URL(string: "https://api.eventreply.com/service/properties")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: TimeData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] timeData in
                self?.requestTime = self?.formatTime(timeData.time) ?? ""
                self?.fetchWeatherData()
            })
            .store(in: &cancellables)
    }

    private func formatTime(_ time: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = isoFormatter.date(from: time) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM HH:mm" // Adjusted format to "Date Month and time"
            return formatter.string(from: date)
        }
        return time
    }

    func fetchWeatherData() {
        let cities = ["Haridwar", "Hyderabad"]
        
        for city in cities {
            let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
            guard let url = URL(string: urlString) else { continue }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: OpenWeatherResponse.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Error fetching weather data: \(error)")
                    }
                }, receiveValue: { [weak self] response in
                    let cityWeather = CityWeather(cityName: city, temperature: response.main.temp)
                    self?.cityWeather.append(cityWeather)
                })
                .store(in: &cancellables)
        }
    }

    func fetchWeeklyWeather(for city: String) {
        // .....
    }
}

// OpenWeatherResponse.swift
struct OpenWeatherResponse: Codable {
    let main: Main
}

struct Main: Codable {
    let temp: Double
}

