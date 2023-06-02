//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by Sanjay Adusumilli on 6/1/23.
//

import Foundation
import Combine

class LocationViewModel {
    
    let networkManager = NetworkManager()
    var locations = [LocationModel]()
    var cancellables = Set<AnyCancellable>()
    
    func fetchLocations(keyword: String, limit: Int, completion:@escaping ((_ data: [LocationModel]) -> Void)) {
        let endPoint = "geo/1.0/direct?q=\(keyword)&limit=\(limit)"
        networkManager.fetchData(endPoint: endPoint, type: [LocationModel].self)
            .sink { completion in
                switch completion {
                case.failure(let error):
                    print("Location fetching failed \(error.localizedDescription)")
                case .finished:
                    print("Location data fetched")
                }
            } receiveValue: { [weak self] data in
                self?.locations = data
                completion(self?.locations ?? [])
            }
            .store(in: &cancellables)
    }
    
    func storeSearchedKey(keyword: String) {
        UserDefaults.standard.set(keyword, forKey: "lastSearch")
    }
    
    func fetchSearchedKey() -> String {
        if let lastSearchedKey = UserDefaults.standard.string(forKey: "lastSearch") {
            return lastSearchedKey
        } else {
            return ""
        }
    }
}
