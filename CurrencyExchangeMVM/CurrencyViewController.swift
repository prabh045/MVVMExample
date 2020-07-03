//
//  ViewController.swift
//  CurrencyExchangeMVM
//
//  Created by Prabhdeep Singh on 28/06/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import CoreData
import os.log

class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let currencyViewModel = CurrencyViewModel()
    var currencyCodes = [NSManagedObject]()
    
    @IBOutlet weak var currencyTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Retyrieving Curency Codes from Core Data
        currencyCodes = CoreDataService.fetchCurrencySymbol()
        for currency in currencyCodes {
            let code = currency.value(forKeyPath: "code") as! String
            CurrencyService.defaultSymbols += code
        }
        
        //Retrieveing Currency Values Via API
        currencyViewModel.retrieveCurrencyValues()
        currencyViewModel.boxDict.bind { _ in
            //Refresh UI on main thread.
            DispatchQueue.main.async {
                self.currencyTableView.reloadData()
            }
        }
        
    }
    
    // MARK: Tableview data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyViewModel.boxDict.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "currencyCell"
        let currencyCode = currencyViewModel.sortedCurrencyCodes[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CurrencyTableViewCell else {
            fatalError("Dequed cell is not instance of currency Cell")
        }
        
        cell.textLabel?.text = currencyCode
        cell.detailTextLabel?.text = "\(currencyViewModel.boxDict.value[currencyCode] ?? 0.0)"
        
        return cell
    }
    
    //MARK: Unwind Method
    
    @IBAction func unwindToCurrencyTable(_ unwindSegue: UIStoryboardSegue) {
        
        guard let sourceViewController = unwindSegue.source as? SymbolsTableViewController else {
            fatalError("Source is not SymbolsTableVC ")
        }
        
        guard sourceViewController.selectedSymbol.isEmpty == false else {
           print("No Symbol Selected")
           return
        }
        
        print("Data from symbolVC \(sourceViewController.selectedSymbol) ")
        CurrencyService.defaultSymbols += ",\(sourceViewController.selectedSymbol.keys.first!)"
        currencyViewModel.retrieveCurrencyValues()
        
    }
    
    
    
    
}

