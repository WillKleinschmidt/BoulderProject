//
//  CCAApp.swift
//  CCA
//
//  Created by William Kleinschmidt on 9/7/21.
//

import SwiftUI
import CoreData

@main
struct CCAApp: App {
    
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .background:
                print("Scene is in background")
                persistenceController.save()
            case .inactive:
                print("Scene is inactive")
            case .active:
                print("Scene is active")
            @unknown default:
                print("Current update added new cases")
            }
            
        }
    }
}
