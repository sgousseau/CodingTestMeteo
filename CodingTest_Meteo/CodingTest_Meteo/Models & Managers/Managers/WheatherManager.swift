//
//  WheatherManager.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import Foundation

class WeatherManager {
    
    private var storage: StorageService! = DefaultStorageService()
    private var network: NetworkService! = DefaultNetworkService()
    private var endpoints = WeatherEndpoints() //v2.5 par défaut
    
    func current(completion: @escaping (Forecast) -> Void, failure: @escaping (Error) -> Void) -> Void {
        forecast(completion: { [unowned self] (forecasts) in
            if let forecast = forecasts.first {
                completion(forecast)
            } else {
                failure(NetworkError.noData(url: self.endpoints.forecast.route))
            }
            
        }, failure: failure)
    }
    
    func forecast(completion: @escaping ([Forecast]) -> Void, failure: @escaping (Error) -> Void) -> Void {
        network.get([Forecast].self, route: endpoints.forecast.route) { (result) in
            switch result {
            case .success(let model):
                completion(model)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
