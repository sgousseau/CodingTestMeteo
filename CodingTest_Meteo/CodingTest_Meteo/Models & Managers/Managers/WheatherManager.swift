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
    
    var current: Forecast?
    var forecast: [Forecast]?
    
    func current(completion: @escaping (Forecast) -> Void, failure: @escaping (Error) -> Void) -> Void {
        forecast(completion: { [unowned self] (forecasts) in
            if let forecast = forecasts.first {
                self.current = forecast
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
                self.forecast = model
                completion(model)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func save() {
        storage.save(encodable: current, key: "currentForecast")
        storage.save(encodable: forecast, key: "5dForecast")
    }
    
    func load() {
        current = storage.load(key: "currentForecast")
        forecast = storage.load(key: "5dForecast")
    }
}
