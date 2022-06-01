//
//  CoreDataTestApp.swift
//  CoreDataTest
//
//  Created by Артем Черненко on 01.06.2022.
//

import SwiftUI

@main
struct CoreDataTestApp: App {
    @StateObject private var storageManager = StorageManager()

    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environment(\.managedObjectContext, storageManager.container.viewContext)
        }
    }
}
