//
//  WheatherEndpoints.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import Foundation

struct WeatherEndpoints {
    
    private let base:       String
    private let key:        String
    private let version:    String
    
    let forecast:           Endpoint
    
    init(baseUrl: String = "http://api.openweathermap.org", apiKey: String = "fc7ed71c05ae38929bbbbe5201004627", version: String = "2.5") {
        self.base = baseUrl
        self.key = apiKey
        self.version = version
        self.forecast = Endpoint(route: String(format: "%@/data/2.5/forecast?q=:city&appid=%@&units=metric", base, key))
    }
    
    class Endpoint {
        
        //Variable pour stocker l'état initial de la route, avec l'ensemble des arguments posibblement utilisables
        private var initial: String = ""
        
        //Variable pour stocker l'état courant de la route configurée par rapport à l'état initial à l'aide des derniers arguments
        var route: String = ""
        
        init(route: String) {
            self.initial = route
            self.configuredWith(args: nil)
        }
        
        //Fonction permettant de configurer les paramètres optionaux de l'url
        @discardableResult
        func configuredWith(args: String?...) -> Self {
            self.route = initial
            
            let argsPattern = "(:\\w+)"
            let argsRgx     = try! NSRegularExpression(pattern: argsPattern, options: [])
            for (_, arg) in args.enumerated() {
                let argsMatches = argsRgx.matches(in: route, options: [], range: route.fullNSRange())
                let range = argsMatches.first!.range(at: 1)
                //Je laisse ici le force unwrap pour être certain de ne pas passer plus d'arguments que l'url ne permet, l'inverse reste possible, on peut passer moins d'arguments.
                let r = route.index(route.startIndex, offsetBy: range.location) ..<
                    route.index(route.startIndex, offsetBy: range.location+range.length)
                
                if let a = arg {
                    route.replaceSubrange(r, with: "\(a)")
                }else {
                    route.replaceSubrange(r, with: "")
                }
            }
            
            //On nettoie les arguments restants
            route = argsRgx.stringByReplacingMatches(in: route, options: [], range: route.fullNSRange(), withTemplate: "")
            
            return self
        }
    }
}
