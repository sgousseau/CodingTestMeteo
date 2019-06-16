//
//  WheatherManager.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

class WeatherManager {
    
    private var storage: StorageService! = DefaultStorageService()
    private var network: NetworkService! = DefaultNetworkService()
    private var endpoints = WeatherEndpoints() //v2.5 par défaut
    
    var current: Forecast?
    var forecast: [Forecast]?
    
    func current(completion: ((Forecast) -> Void)? = nil, failure: ((Error) -> Void)? = nil) -> Void {
        forecast(completion: { [unowned self] (forecasts) in
            if let forecast = forecasts.first {
                self.current = forecast
                completion?(forecast)
            } else {
                failure?(NetworkError.noData(url: self.endpoints.forecast.route))
            }
            
        }, failure: failure)
    }
    
    func forecast(completion: (([Forecast]) -> Void)? = nil, failure: ((Error) -> Void)? = nil) -> Void {
        network.get(Forecasts.self, route: endpoints.forecast.configuredWith(args: "Paris").route) { (result) in
            switch result {
            case .success(let model):
                self.forecast = model.list
                completion?(model.list)
            case .failure(let error):
                failure?(error)
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

extension WeatherManager: ReactiveCompatible {}

//Peut être factorisé
extension Reactive where Base: WeatherManager {
    func current() -> Observable<Forecast> {
        return forecast()
            .map { $0.first }
            .unwrap()
    }
    
    func forecast() -> Observable<[Forecast]> {
        return Observable.deferred({ () -> Observable<[Forecast]> in
            return Observable.create({ (observer) -> Disposable in
                
                self.base.forecast(completion: { (model) in
                    observer.onNext(model)
                    observer.onCompleted()
                }, failure: { (error) in
                    observer.onError(error)
                })
                
                return Disposables.create()
            })
        })
    }
}
