//
//  WeatherViewModel.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09
//

import Foundation
import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var temperature: String = "-"
    @Published var description: String = "-"
    @Published var humidity: String = "-"
    @Published var iconURL: URL?
    
    var clothingAdvice: String {
        let desc = description.lowercased()

        switch desc {
        case let d where d.contains("rain"):
            return "Wear a raincoat or carry an umbrella ☔️"
        case let d where d.contains("cloud"):
            return "It’s cloudy, consider wearing something warm ☁️"
        case let d where d.contains("clear"), let d where d.contains("sun"):
            return "Light clothes are fine, it's sunny ☀️"
        case let d where d.contains("snow"):
            return "Bundle up! It’s snowing ❄️"
        case let d where d.contains("storm"):
            return "Stay indoors if you can, and wear protective clothes ⚠️"
        default:
            return "Dress comfortably for the weather 👕"
        }
    }


    private let apiKey = "2dd6dab75cc1d9cdbff6291a45a90dd8"
    private var cancellable: AnyCancellable?

    func fetchWeather(for city: String) {
        guard let urlCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string:
                "https://api.openweathermap.org/data/2.5/weather?q=\(urlCity)&appid=\(apiKey)&units=metric")
        else {
            print("Invalid URL")
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching weather: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.cityName = response.name
                self?.temperature = "\(Int(response.main.temp))°C"
                self?.humidity = "\(response.main.humidity)%"
                self?.description = response.weather.first?.description.capitalized ?? "-"
                if let icon = response.weather.first?.icon {
                    self?.iconURL = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
                }
            })
    }
}

