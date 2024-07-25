//
//  ContentView.swift
//  moneyTracker
//
//  Created by admin on 20.12.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var product: FetchedResults<Product>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
               Text("\(Int(totalValue())) € (Today)")
                    .foregroundColor(.black)
                    .padding(.horizontal)
                List{
                    ForEach(product){ product in
                        NavigationLink(destination: EditProductView(product: product)){
                            HStack{
                                VStack(alignment: .leading,spacing: 6){
                                    Text(product.name!)
                                        .bold()
                                    Text("\(Int(product.prices)) €")
                                        .foregroundColor(.blue)
                                }
                                Spacer()
                                Text(showTime(date: product.date!))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteProduct)
                }
            }
            .navigationBarTitle("Product", displayMode: .inline)
            .background(.orange)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Add"){
                        showingAddView.toggle()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView){
                AddProductView()
            }
        }
    }
    
    func deleteProduct(offsets: IndexSet){
        withAnimation{
            offsets.map { product[$0] }.forEach(managedObjContext.delete)
            DataController().save(context: managedObjContext)
        }
    }
    func totalValue()-> Double{
        var pricesToday: Double = 0
        for item in product {
            if Calendar.current.isDateInToday(item.date!){
                pricesToday += item.prices
            }
        }
        return pricesToday
    }
    
    func showTime(date: Date) -> String{
        //timeIntervalSinceNow is in ms
        let minutes = Int(-date.timeIntervalSinceNow)/60
        let hours = minutes/60
        let days = hours/24
        
        if minutes < 120 {
            return "\(minutes) minutes ago"
        } else if minutes >= 120 && hours < 48 {
            return "\(hours) hours ago"
        }else{
            return "\(days) days ago"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
