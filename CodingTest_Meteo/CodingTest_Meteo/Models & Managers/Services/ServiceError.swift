//
//  ServiceError.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case notImplemented(service: String)
}
