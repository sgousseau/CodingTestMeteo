//
//  WheatherViewModel.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class WeatherViewModel {
    
    let manager = WeatherManager()
    var current: Forecast?
    var forecast: [Forecast]?
    
    var isLoading = ActivityIndicator()
    var bag: DisposeBag! = DisposeBag()
    
    init() {
        manager.load()
        current = manager.current
        forecast = manager.forecast
        
    }
    
    var tempText: String {
        return "\(current?.main.temp ?? 0)°"
    }
    
    var windText: String {
        return "\(current?.wind?.speed ?? 0) m/s"
    }
    
    var cloudsText: String {
        return "\(current?.clouds?.all ?? 0) %"
    }
    
    var humidityText: String {
        return "\(current?.main.humidity ?? 0) %"
    }
    
    var pressureText: String {
        return "\(Int(current?.main.pressure ?? 0.0) ) hpa"
    }
    
    func currentWeatherIcon() -> UIImage? {
        return UIImage(named: current?.weather.first?.icon ?? "")
    }
    
    func detailCollectionViewCellText(forecast: Forecast? = nil) -> NSAttributedString {
        
        guard let model = forecast ?? current else {
            return NSAttributedString()
        }
        
        let pattern = "{hour}h - {temp}°\n{wind} m/s\n{pressure} hpa"
        
        let copy = NSMutableAttributedString(string: pattern)
        let mutableString = copy.mutableString
        let date = Date(timeIntervalSince1970: TimeInterval(model.dt))
        let hour = DateFormatter.Formatter.hour.string(from: date)
        let pressure = "\(Int(model.main.pressure) ) hpa"
        let wind = "\(model.wind?.speed ?? 0) m/s"
        let temp = "\(model.main.temp)°"
        mutableString.replaceOccurrences(of: "{hour}", with: hour, options: .backwards, range: mutableString.range(of: "{hour}"))
        mutableString.replaceOccurrences(of: "{temp}", with: "\(temp)", options: .backwards, range: mutableString.range(of: "{temp}"))
        mutableString.replaceOccurrences(of: "{wind}", with: "\(wind)", options: .backwards, range: mutableString.range(of: "{wind}"))
        mutableString.replaceOccurrences(of: "{pressure}", with: "\(pressure)", options: .backwards, range: mutableString.range(of: "{pressure}"))
        return copy
    }
    
    func refreshData() {
        manager.rx.current()
            .trackActivity(isLoading)
            .map(Optional.init)
            .retryOnBecomesReachable(nil, reachabilityService: try! DefaultReachabilityService())
            .unwrap()
            .subscribe()
            .disposed(by: bag)
    }
}
