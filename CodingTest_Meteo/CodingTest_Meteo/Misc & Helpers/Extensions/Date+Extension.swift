//
//  Date+Extension.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import Foundation

extension Date {
    func tomorrow() -> Date {
        let today = Date()
        let tomorrow = Date(timeInterval: 86400, since: today)
        let cal = Calendar(identifier: .gregorian)
        return cal.startOfDay(for: tomorrow)
    }
    
    func today(plus: Int) -> Date {
        let today = Date()
        let factor = plus > 0 ? plus : 0
        let day = Date(timeInterval: TimeInterval(86400 * factor), since: today)
        let cal = Calendar(identifier: .gregorian)
        return cal.startOfDay(for: day)
    }
}
