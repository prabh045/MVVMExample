//
//  SymbolsTableViewController.swift
//  CurrencyExchangeMVM
//
//  Created by Prabhdeep Singh on 30/06/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import os.log

class SymbolsTableViewController: UITableViewController {
    
    let currencyViewModel = CurrencyViewModel()
    var selectedSymbol = [String:String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        currencyViewModel.retrieveCurencySymbols()
        
        currencyViewModel.symbolDict.bind { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return currencyViewModel.symbolDict.value.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "symbolCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = currencyViewModel.sortedCurrencySymbols[indexPath.row]
        cell.detailTextLabel?.text = currencyViewModel.symbolDict.value[currencyViewModel.sortedCurrencySymbols[indexPath.row]]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let key = currencyViewModel.sortedCurrencySymbols[indexPath.row]
        let value = currencyViewModel.symbolDict.value[key]
        
        selectedSymbol[key] = value!
        
        let currencyCode = CurrencyCode(code: key)
        
        if (CoreDataService.saveCurrencySymbol(currencyCode)) {
            performSegue(withIdentifier: "symbolSelected", sender: self)
        } else {
            //Display some kind of alert
        }
        
        //performSegue(withIdentifier: "symbolSelected", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print(selectedSymbol)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
