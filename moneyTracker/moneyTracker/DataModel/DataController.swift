//
//  DataController.swift
//  moneyTracker
//
//  Created by admin on 20.12.22.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    //Access to DataModel
    let container = NSPersistentContainer(name: "ProductModel")

    init(){
        container.loadPersistentStores{desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data saved")
        }   catch{
            print("Not enough storage left")
        }
    }
    
    func addProduct(name: String, prices: Double, context: NSManagedObjectContext){
       let product = Product(context: context)
        product.id = UUID()
        product.date = Date()
        product.name = name
        product.prices = prices
        save(context: context)
    }
    
    func editProduct(product: Product, name: String, prices: Double, context: NSManagedObjectContext){
        product.date = Date()
        product.name = name
        product.prices = prices
        save(context: context)
    }
}
