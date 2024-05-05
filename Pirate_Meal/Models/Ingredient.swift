//
//  Ingredient.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbachk on 20.02.24.
//

import Foundation

struct Ingredient: Codable, Identifiable {
    
    let id : Int
    let name : String
    let amount: Double
    let unit: String
    
}
