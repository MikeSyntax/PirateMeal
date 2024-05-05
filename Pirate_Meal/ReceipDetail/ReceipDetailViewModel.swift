//
//  PreviewShoppingListRepository.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 21.02.24.
//

import Foundation


class ReceipDetailViewModel: ObservableObject{
    
    @Published var title: String
    @Published var id: Int
    @Published var image: String
    @Published var instruction: String = ""
    @Published var ingredients: [Ingredient] = []
    private var previewRepo: APIReceipeRepository
    private var shoppingRepo = PreviewShoppingListRepository.shared
    
    init(receip: Receip){
        self.previewRepo = .init()
        self.id = receip.id
        self.title = receip.title
        self.image = receip.image
    }
    
    func addIngredientsToShoppingList(){
        
        shoppingRepo.createItems(ingredients)
        
    }
    
    @MainActor
    func loadDetails(){
        Task {
            do {
                //TODO Dummydaten ersetzen
                let fullReceip = try await previewRepo.getFullRecipeById(id) 
                
                self.instruction = fullReceip.instructions
                self.ingredients = fullReceip.extendedIngredients
            } catch {
                print(error)
            }
        }
    }
}
