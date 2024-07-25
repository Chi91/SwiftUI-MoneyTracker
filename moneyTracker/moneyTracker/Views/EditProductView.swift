//
//  EditProductView.swift
//  moneyTracker
//
//  Created by admin on 20.12.22.
//

import SwiftUI


struct EditProductView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var product: FetchedResults<Product>.Element
    
    @State private var name = ""
    @State private var prices: Double = 0
    
    var body: some View {
        Form{
            Section{
                TextField("\(product.name!)", text: $name)
                    .onAppear{
                        name = product.name!
                        prices = product.prices
                    }
                VStack{
                    Text("Prices: \(Int(prices))")
                    Slider(value: $prices, in: 0...1000, step: 1)
                }
                .padding()
                HStack{
                    Spacer()
                    Button("Submit"){
                        DataController().editProduct(product: product, name: name, prices: prices, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

