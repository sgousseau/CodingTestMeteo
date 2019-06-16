//
//  NetworkService.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badUrl(url: String)
    case invalidStatusCode(status: Int)
    case invalidResponse(url: String)
    case noData(url: String)
    case serialization(error: Error)
}

protocol NetworkService {
    func get<T>(_ type: T.Type, route: String, callback: ((Result<T, Error>) -> Void)?) where T: Decodable
}

typealias DefaultNetworkService = URLSessionNetwork

class AlamofireNetwork: NetworkService {
    func get<T>(_ type: T.Type, route: String, callback: ((Result<T, Error>) -> Void)?) where T: Decodable {
        callback?(Result.failure(ServiceError.notImplemented(service: "Alamofire")))
    }
}

class JustNetwork: NetworkService {
    func get<T>(_ type: T.Type, route: String, callback: ((Result<T, Error>) -> Void)?) where T: Decodable {
        callback?(Result.failure(ServiceError.notImplemented(service: "JustNetwork")))
    }
}

class AnyOtherNetwork: NetworkService {
    func get<T>(_ type: T.Type, route: String, callback: ((Result<T, Error>) -> Void)?) where T: Decodable {
        callback?(Result.failure(ServiceError.notImplemented(service: "AnyOtherNetwork")))
    }
}

class URLSessionNetwork: NetworkService {
    
    var session: URLSession
    var sessionCfg: URLSessionConfiguration
    
    private var _currentTask: URLSessionDataTask?
    
    init() {
        sessionCfg = URLSessionConfiguration.default
        session = URLSession(configuration: sessionCfg)
    }
    
    ///Execute une requete get standard, ne fonctionne pas pour un get sans data retournée
    func get<T>(_ type: T.Type, route: String, callback: ((Result<T, Error>) -> Void)?) where T: Decodable {
        print(route)
        //Gestion simpliste pour ce wrapper, on clean simplement la requete precedente si il y a.
        if let task = _currentTask { task.cancel() }
        
        if let url = route.toURL() {
            _currentTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let e = error {
                    callback?(Result.failure(e))
                }else {
                    if let r = response as? HTTPURLResponse {
                        if 200 ... 299 ~= r.statusCode {
                            if let data = data {
                                do {
                                    print(String(data: data, encoding: .utf8))
                                   let model = try JSONDecoder().decode(type, from: data)
                                    callback?(Result.success(model))
                                } catch {
                                    callback?(Result.failure(NetworkError.serialization(error: error)))
                                }
                            } else {
                                callback?(Result.failure(NetworkError.noData(url: route)))
                            }
                        }else {
                            callback?(Result.failure(NetworkError.invalidStatusCode(status: r.statusCode)))
                        }
                    }else {
                        callback?(Result.failure(NetworkError.invalidResponse(url: route)))
                    }
                }
            })
            
            _currentTask?.resume()
            
        }else {
            callback?(Result.failure(NetworkError.badUrl(url: route)))
        }
    }
}
