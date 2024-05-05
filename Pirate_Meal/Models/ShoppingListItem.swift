//
//  ShoppingListItem.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 20.02.24.
//

import Foundation


struct ShoppingListItem: Identifiable{
    
    let id:   Int
    let name: String
    let quantity: Double
    let unit: String
    var checked: Bool
    
}
