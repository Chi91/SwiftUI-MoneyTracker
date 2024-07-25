//
//  AddProductView.swift
//  moneyTracker
//
//  Created by admin on 20.12.22.
//

import SwiftUI

struct AddProductView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var prices: Double = 0
    
    var body: some View {
        Form{
            Section{
                TextField("Product Name", text: $name)
                VStack{
                    Text("Prices: \(Int(prices)) €")
                    Slider(value: $prices,in: 0...1000, step: 1)
                }
                .padding()
                HStack{
                    Spacer()
                    Button("Submit"){
                        DataController().addProduct(name: name, prices: prices, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                    
                }
            }
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
