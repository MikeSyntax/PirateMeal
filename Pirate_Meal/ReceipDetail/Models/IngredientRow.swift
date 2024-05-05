//
//  PreviewShoppingListRepository.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 21.02.24.
//

import SwiftUI

struct IngredientRow: View {
    
    let ingredient: Ingredient
    
    var body: some View {
        VStack{
            HStack{
                Text(String(ingredient.amount.formatted()))
                Text(ingredient.unit)
                Text(ingredient.name)
                    .bold()
            }.padding(.horizontal)
            Divider()
        }
    }
    
    
}

#Preview {
    IngredientRow(ingredient: Ingredient(id: 1, name: "Olivenöl", amount: 200, unit: "ml"))
}
