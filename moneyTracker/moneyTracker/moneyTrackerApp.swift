//
//  moneyTrackerApp.swift
//  moneyTracker
//
//  Created by admin on 20.12.22.
//

import SwiftUI

@main
struct moneyTrackerApp: App {
    //Inject database
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
