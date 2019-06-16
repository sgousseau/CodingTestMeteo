//
//  DateFormatter+Extension.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import Foundation

extension DateFormatter {
    struct Formatter {
        static var dayDateString: DateFormatter {
            return DateFormatter(format: "E dd")
        }
        
        static var monthDay: DateFormatter {
            return DateFormatter(format: "MM/dd")
        }
        
        static var dayString: DateFormatter {
            return DateFormatter(format: "EEEE")
        }
        
        static var dayHourString: DateFormatter {
            return DateFormatter(format: "EEEE H")
        }
        
        static var hour: DateFormatter {
            return DateFormatter(format: "H")
        }
    }
    
    convenience init(format: String) {
        self.init()
        dateFormat = format
        locale = Locale(identifier: "fr_FR")
    }
}
