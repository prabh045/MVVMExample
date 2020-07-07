//
//  CoreDataService\.swift
//  CurrencyExchangeMVM
//
//  Created by Prabhdeep Singh on 03/07/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import CoreData
import os.log

class CoreDataService {
    
    static func saveCurrencySymbol(_ currencyCode: CurrencyCode) -> Bool {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cant get app delegate")
        }
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Currency", in: managedObjectContext)!
        
        let currencySymbolObject = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        
        currencySymbolObject.setValue("\(currencyCode.code)", forKey: "code")
        
        do {
            try managedObjectContext.save()
            os_log("Data Saved to Core Data")
            return true
        } catch {
            os_log(OSLogType.debug, "Error saving currency to core data")
            return false
        }
        
    }
    
    static func fetchCurrencySymbol() -> [NSManagedObject] {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cant get app delegate")
        }
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Currency")
        
        do {
            let currency = try managedObjectContext.fetch(fetchRequest)
            os_log("Fetched Currency Codes Successfully")
            return currency
        } catch {
            os_log("Error in fetching Currency Codes")
            return []
        }
    }
    
    static func deleteCurrencySymbol(_ code: NSManagedObject) -> Bool {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cant get app delegate")
        }
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        managedObjectContext.delete(code)
        
        do {try managedObjectContext.save()
            os_log("Currency Code deleted successfully")
            //CurrencyService.defaultSymbols
            return true
        }
        catch {
            os_log("Could not save after deleting Object, Core data")
            return false
        }
    }
}
