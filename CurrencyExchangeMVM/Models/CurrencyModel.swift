//
//  CurrencyModel.swift
//  CurrencyExchangeMVM
//
//  Created by Prabhdeep Singh on 29/06/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

struct CurrencyModel: Codable {
    var success: Bool
    var timestamp: Float
    var base: String
    var date: String
    var rates: Dictionary<String, Double>
}



