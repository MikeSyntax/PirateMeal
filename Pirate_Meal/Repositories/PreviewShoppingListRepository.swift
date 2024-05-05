//
//  PreviewShoppingListRepository.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 21.02.24.
//

import Foundation


class PreviewShoppingListRepository{
    
    static let shared = PreviewShoppingListRepository()
    private var shoppingList: [ShoppingListItem] = []
    
    private let persistentStore = PersistentStore.shared
    
    //sperrt den Zugriff auf init um versehentliches Instanzieren zu vermeiden
    private init(){}
    
    
    
    func getItems()->[ShoppingListItem]{
        let fetchRequest = CDShoppingItem.fetchRequest()
        
        do{
            let data = try persistentStore.context.fetch(fetchRequest).compactMap{entity in
                ShoppingListItem(id: Int(entity.id) , name: entity.name ?? "", quantity: entity.quantity, unit: entity.unit ?? ""   , checked: entity.checked)
            }
            shoppingList = data.filter{
                $0.name != ""
            }
            return shoppingList
            
        }catch{
            print("something went wrong while requesting core data: \(error)")
        }
        return shoppingList
    }
    
    func createItems(_ ingredientList: [Ingredient]){
        for ingredient in ingredientList{
            if shoppingList.contains(where: {
                $0.name == ingredient.name
            }){
                let index = shoppingList.firstIndex(where: {
                    $0.name == ingredient.name
                })
                let entity = getSingleEntity(id: shoppingList[index!].id)
                entity?.quantity += ingredient.amount
                
                persistentStore.saveChanges()
                
            }else{
                let entity = CDShoppingItem(context: persistentStore.context)
                entity.id = Int64(ingredient.id)
                entity.name = ingredient.name
                entity.quantity = ingredient.amount
                entity.unit = ingredient.unit
                entity.checked = false
                
                persistentStore.saveChanges()
            }
        }
    }
    
    func toggleChecked(id: Int){
        guard let entity = getSingleEntity(id: id) else{
            return
        }
        
        entity.checked = !entity.checked
        persistentStore.saveChanges()
    }
    
    
    
    func deleteItem(id: Int){
        guard let entity = getSingleEntity(id: id) else {
            return
        }
        persistentStore.context.delete(entity)
        persistentStore.saveChanges()
    }
    
    func clearAllChecked(){
        let request = CDShoppingItem.fetchRequest()
        request.predicate = NSPredicate(format: "checked = %@", NSNumber(value: true))
        do{
            let entities = try persistentStore.context.fetch(request)
            for entity in entities {
                persistentStore.context.delete(entity)
            }
        }catch{
            print("fetching entities failed: \(error)")
        }
    }
    
    func getSingleEntity(id: Int)->CDShoppingItem?{
        let request = CDShoppingItem.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", id)
        do{
            let entity = try persistentStore.context.fetch(request)
            return entity.first
        }catch{
            print("fetching entity failed: \(error)")
        }
        return nil
    }
}
