//
//  SymbolModel.swift
//  CurrencyExchangeMVM
//
//  Created by Prabhdeep Singh on 30/06/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

struct SymbolModel: Codable {
    
    var success: Bool
    var symbols: Dictionary<String, String>
    
}
