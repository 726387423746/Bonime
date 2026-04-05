//
//  BonimeApp.swift
//  Bonime
//
//  Created by BORA on 5.04.2026.
//

import SwiftUI
import CoreData

@main
struct BonimeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
