//
//  Box.swift
//  CurrencyExchangeMVM
//
//  Created by Prabhdeep Singh on 30/06/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

class Box<T> {
    
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value:T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}

// Made a listener which is called when a value changes
// Listner is simply a closure which is called when a value changes

// In more simple terms a function is called each time value changes
