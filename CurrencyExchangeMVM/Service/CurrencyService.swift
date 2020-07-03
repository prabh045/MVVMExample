//
//  CurrencyService.swift
//  CurrencyExchangeMVM
//
//  Created by Prabhdeep Singh on 29/06/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

enum CurrencyErrors: Error {
    case noData
    case noResponse
    case invalidResponse
    case failedRequest
    case invalidData
    
}

class CurrencyService {
    
    static private let api_key = "_Your_api_key_here_"
    static public var defaultSymbols = "USD,INR,GBP"
    
    init() {
        
    }
    
    static func retrieveCurrencyData(completion: @escaping (CurrencyModel?,CurrencyErrors?) -> Void) {
        let url = "http://data.fixer.io/api/latest?access_key=\(api_key)&symbols=\(defaultSymbols)&format=1"
        let serviceUrl = URL(string: url)
        let serviceRequest = URLRequest(url: serviceUrl!)
        print("URL IS \(url)")
        
        URLSession.shared.dataTask(with: serviceRequest) { (data, response, error) in
            
            guard error == nil else {
                print("Some error occured in retrieving currency rates \(String(describing: error))")
                completion(nil, .failedRequest)
                return
            }
            
            guard let data = data else {
                print("No data retrieved from server")
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Unable to process response")
                completion(nil,.invalidResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                print("Failure response from server \(response.statusCode)")
                completion(nil, .failedRequest)
                return
            }
            
            do {
                let currency = try JSONDecoder().decode(CurrencyModel.self, from: data)
                completion(currency,nil)
            } catch {
                print("Error in decoding")
                completion(nil, .invalidData)
            }
            
            
        }.resume()
    }
    
    static func retrieveSymbols(completion: @escaping (SymbolModel?,CurrencyErrors?) -> Void) {
        print("retrieve symbols ran")
        let url = "http://data.fixer.io/api/symbols?access_key=\(api_key)"
        let serviceUrl = URL(string: url)
        let serviceRequest = URLRequest(url: serviceUrl!)
        
        URLSession.shared.dataTask(with: serviceRequest) { (data, response, error) in
            
            guard error == nil else {
                print("Some error occured in retrieving currency rates \(String(describing: error))")
                completion(nil, .failedRequest)
                return
            }
            
            guard let data = data else {
                print("No data retrieved from server")
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Unable to process response")
                completion(nil,.invalidResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                print("Failure response from server \(response.statusCode)")
                completion(nil, .failedRequest)
                return
            }
            
            do {
                let symbolModel = try JSONDecoder().decode(SymbolModel.self, from: data)
                print("-----1----")
                completion(symbolModel,nil)
                
            } catch {
                print("Error in decoding symbols")
            }
        }.resume()
        
    }
    
    
}
//
//URLSession.shared.dataTask(with: url) { (Data?, URLResponse?, Error?) in
//
//     }
