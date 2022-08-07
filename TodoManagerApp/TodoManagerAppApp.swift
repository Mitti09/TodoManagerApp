//
//  TodoManagerAppApp.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/02/22.
//

import SwiftUI

@main
struct TodoManagerAppApp: App {
    let persistenceController = PersistenceController.shared.managedObjectContext

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController)
        }
    }
}
