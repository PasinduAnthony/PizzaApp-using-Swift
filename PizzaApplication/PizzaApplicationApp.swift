//
//  PizzaApplicationApp.swift
//  PizzaApplication
//
//  Created by Pasindu on 2022-03-30.
//

import SwiftUI

@main
struct PizzaApplicationApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
