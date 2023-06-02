//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Sanjay Adusumilli on 6/1/23.
//

import Foundation
import Combine

class WeatherViewModel {
    
    var cancellable = Set<AnyCancellable>()
    var weatherData = [WeatherModel]()
    let networkManager = NetworkManager()
    
    // Handle Weather Data Fetching
    func fetchWeatherData(lat: Double, lng: Double, completion:@escaping ((_ data: [WeatherModel]) -> Void)) {
        
        let endpoint = "data/2.5/weather?lat=\(lat)&lon=\(lng)"
        networkManager.fetchData(endPoint: endpoint, type: WeatherModel.self)
            .sink { completion in
                switch completion {
                case.failure(let error):
                    print("Location fetching failed \(error.localizedDescription)")
                case .finished:
                    print("Location data fetched")
                }
            } receiveValue: { [weak self] weatherData in
                self?.weatherData.append(weatherData)
                completion(self?.weatherData ?? [])
            }
            .store(in: &cancellable)
    }
}
