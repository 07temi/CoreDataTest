//
//  StorageManager.swift
//  CoreDataTest
//
//  Created by Артем Черненко on 01.06.2022.
//

import Foundation
import CoreData

class StorageManager: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataTest")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
