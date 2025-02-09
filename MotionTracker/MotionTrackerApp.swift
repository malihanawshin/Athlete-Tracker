//
//  MotionTrackerApp.swift
//  MotionTracker
//
//  Created by Maliha on 9/2/25.
//

import SwiftUI

@main

struct MotionTrackerApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

