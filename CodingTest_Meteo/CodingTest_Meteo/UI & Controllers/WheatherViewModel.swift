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
import RxCocoa

class WeatherViewModel {
    
    let manager = WeatherManager()
    var current: Forecast?
    var forecast: [Forecast]?
    
    var isLoading = ActivityIndicator()
    var shouldRefresh = PublishRelay<Void>()
    var bag: DisposeBag! = DisposeBag()
    
    init() {
        manager.load()
        current = manager.current
        forecast = manager.forecast
        
        shouldRefresh
            .bind { [unowned self] in
                self.refreshData()
            }
            .disposed(by: bag)
    }
    
    var tempText: String {
        return "Paris\n\(current?.main.temp ?? 0)°"
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
    
    func weatherIcon(weather: Weather) -> UIImage? {
        return UIImage(named: weather.icon)
    }
    
    func forecastIcon(forecast: Forecast) -> UIImage? {
        guard let weather = forecast.weather.first else {
            return nil
        }
        return weatherIcon(weather: weather)
    }
    
    private var _byDays: [[Forecast]]!
    var fiveDaysForecast: [[Forecast]] {
        if let array = _byDays, !array.isEmpty {
            return array
        }
        
        if let forecast = forecast {
            _byDays = Dictionary(grouping: forecast, by: { (elt) -> String in
                DateFormatter.Formatter.monthDay.string(from: Date(timeIntervalSince1970: TimeInterval(elt.dt))).capitalized
            })
            .sorted(by: { (kv1, kv2) -> Bool in
                kv1.key < kv2.key
            })
            .map({ $0.value })
            
            return _byDays
        }
        
        return []
    }
    
    func detailCollectionViewCellText(pattern: NSAttributedString, forecast: Forecast? = nil) -> NSAttributedString {
        
        guard let model = forecast ?? current else {
            return NSAttributedString()
        }
        
        let copy = pattern.mutableCopy() as! NSMutableAttributedString
        let mutableString = copy.mutableString
        let date = Date(timeIntervalSince1970: TimeInterval(model.dt))
        let day = DateFormatter.Formatter.dayDateString.string(from: date).capitalized
        let hour = DateFormatter.Formatter.hour.string(from: date)
        let temp = "\(model.main.temp)"
        mutableString.replaceOccurrences(of: "{day}", with: day, options: .backwards, range: mutableString.range(of: "{day}"))
        mutableString.replaceOccurrences(of: "{hour}", with: hour, options: .backwards, range: mutableString.range(of: "{hour}"))
        mutableString.replaceOccurrences(of: "{temp}", with: "\(temp)", options: .backwards, range: mutableString.range(of: "{temp}"))
        return copy
    }
    
    func refreshData() {
        _byDays = nil
        
        manager.rx.current()
            .retry(3)
            .trackActivity(isLoading)
            .map(Optional.init)
            .retryOnBecomesReachable(nil, reachabilityService: try! DefaultReachabilityService())
            .unwrap()
            .subscribe()
            .disposed(by: bag)
    }
}
