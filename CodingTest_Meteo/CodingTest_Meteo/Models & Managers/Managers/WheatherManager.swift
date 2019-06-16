//
//  WheatherManager.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import Foundation

class WeatherManager {
    
    var storage: StorageService! = DefaultStorageService()
    var network: NetworkService! = DefaultNetworkService()
    
    func current(completion: (Forecast) -> Void) {
        
    }
    
    func forecast(completion: ([Forecast]) -> Void) {
        
    }
    
}
