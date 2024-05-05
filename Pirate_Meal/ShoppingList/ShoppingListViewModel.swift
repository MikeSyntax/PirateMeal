//
//  PreviewShoppingListRepository.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 21.02.24.
//

import Foundation


class ShoppingListViewModel: ObservableObject{
    
    @Published var shoppingList: [ShoppingListItem] = []
    private var shoppingRepo = PreviewShoppingListRepository.shared
    
    
    init(){
        getItems()
    }
    
    func getItems(){
        
        //TODO Dummy Daten ersetzen
        self.shoppingList = shoppingRepo.getItems().sorted(by: {itemOne, itemTwo in
            itemTwo.checked != itemOne.checked
        })
    }
    
    
    func deleteItem(itemID: Int){
        shoppingRepo.deleteItem(id: itemID)
        print("try to delete")
        getItems()
    }
    
    func clearAllChecked(){
        shoppingRepo.clearAllChecked()
        getItems()
    }
    
    
    func toggleChecked(id: Int){
        shoppingRepo.toggleChecked(id: id)
        getItems()
    }
}
