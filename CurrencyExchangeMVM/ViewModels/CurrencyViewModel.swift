//
//  CurrencyViewModel.swift
//  CurrencyExchangeMVM
//
//  Created by Prabhdeep Singh on 29/06/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

class CurrencyViewModel {
    
    
    var currencyDictionary = [String:Double]()
    var boxDict: Box<Dictionary<String,Double>> = Box([String:Double]())
   
    var symbolDict: Box<Dictionary<String,String>> = Box([String:String]())
    var sortedCurrencyCodes = [String]()
    
    var sortedCurrencySymbols = [String]()
    
    //Not exposing Currencny model to view controller
    private var currencyModel: CurrencyModel?
    private var symbolModel: SymbolModel?
    
    func retrieveCurrencyValues() {
        
        CurrencyService.retrieveCurrencyData { (currencyModel,error) in
            
            if let error = error {
                print("error in currency rates \(error)")
                return
            }
            self.currencyModel = currencyModel
            
            //converting data to form which is displayable to views
            self.currencyDictionary = currencyModel!.rates
            self.sortedCurrencyCodes = self.currencyDictionary.keys.sorted()
            self.boxDict.value = self.currencyDictionary
            
            
        }
        
    }
    
    func retrieveCurencySymbols() {
        print("this symbols ran")
        CurrencyService.retrieveSymbols { (symbolModel, error) in
            
            if let error = error {
                print("error in currency rates \(error)")
                return
            }
            
            self.symbolModel = symbolModel
            self.sortedCurrencySymbols = self.symbolModel?.symbols.keys.sorted() ?? []
            self.symbolDict.value = self.symbolModel?.symbols ?? [:]
        }
    }
    
}
