//
//  PreviewShoppingListRepository.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 21.02.24.
//

import Foundation

class APIReceipeRepository{
    
    struct ErrorRecipe: Error {
        let message: String
    }
    
    private let apiKeyRecipe = ApiKeys().apiKeyOne
    private let secondKey = ApiKeys().apiKeyTwo
    
    func searchReceipes(_ search: String) async throws -> SearchResult {
        guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKeyRecipe)\(search.isEmpty ? "" : "&query=\(search)")&number=20") else {
            throw ErrorRecipe(message: "Something went wrong while loading receipes from API")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(SearchResult.self, from: data)
    }
    
    func getFullRecipeById(_ id: Int) async throws -> FullRecipe {
        guard let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/information?apiKey=\(apiKeyRecipe)") else {
            throw ErrorRecipe(message: "Something went wrong while loading full receipe")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(FullRecipe.self, from: data)
    }
    
    func extendedSearch(search: String, vegan: Bool, glutenFree: Bool, excludedIngredients: String) async throws -> SearchResult{
        guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKeyRecipe)\(search.isEmpty ? "" : "&query=\(search)\(vegan ? "&diet=vegan":"")\(glutenFree ? "&intolerances=gluten":"")\(excludedIngredients.isEmpty ? "":excludedIngredients.lowercased().replacing(" ", with: ""))")&number=20") else {
            
            throw ErrorRecipe(message: "Something went wrong while loading receipes from API")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        print(data)
        
        return try JSONDecoder().decode(SearchResult.self, from: data)
    }
}
