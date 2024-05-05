//
//  FullRecipe.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 21.02.24.
//

import Foundation


struct FullRecipe: Codable, Identifiable{
    
    let id: Int
    let title: String
    let image: String  //bleibt String weil das Async Image das URL bauen übernimmt
    let instructions: String
    let extendedIngredients: [Ingredient]
}
