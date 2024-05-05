//
//  PersistentStore.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 23.02.24.
//

import Foundation
import CoreData

class PersistentStore{
    
    static let shared = PersistentStore() // DataStore wird gespeichert in der statischen `shared` Konstanten
    private let container : NSPersistentContainer // Eine private Konstante, die den container von CoreData speichert
    var context: NSManagedObjectContext{
        self.container.viewContext
    }
    private init() {
        self.container = NSPersistentContainer(name: "ShoppingListItemEntity")
        self.container.loadPersistentStores{_, error in
            if let error{
                fatalError("something went wrong while loading database: \(error)")
            }
        }// Container wird initialisiert, mit Bezug auf den Namen des DataModels
    }
    func saveChanges() {
        guard self.context.hasChanges else {
            return
        }
        do {
            try self.context.save()
        } catch let error {
            print("error occurred while saveing changes: \(error.localizedDescription)")
        }
    }
    
    
}
