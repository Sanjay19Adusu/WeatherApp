//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Sanjay Adusumilli on 6/1/23.
//

import Foundation
import Combine

class NetworkManager {
    
    var cancellables = Set<AnyCancellable>()
    let baseURL = "https://api.openweathermap.org/"
    let api = "dd4c451ddabfe96297b5afc9e925ea2e"
    
    func fetchData<T: Codable>(endPoint: String, type: T.Type) -> Future <T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self = self, let url = URL(string: baseURL.appending("\(endPoint)&appid=\(api)")) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) -> Data in
                    guard let responseData = response as? HTTPURLResponse, 200...299 ~= responseData.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknownError))
                        }
                    }
                } receiveValue: { responseData in
                    promise(.success(responseData))
                }
                .store(in: &cancellables)

        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknownError
}
