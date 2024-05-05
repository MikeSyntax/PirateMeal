//
//  BrowseRecipeViewModel.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 19.02.24.
//

import Foundation


class BrowseRecipeViewModel: ObservableObject{
    
    @Published var receips: [Receip] = []
    @Published var searchString: String = ""
    @Published var excludeIngredients: String = ""
    @Published var vegan: Bool = false
    @Published var glutenFree: Bool = false
    @Published var searchIsVisible: Bool = false
    private var previewRepo: APIReceipeRepository
    
    init(){
        self.previewRepo = .init()
    }
    
    @MainActor
    func loadReceips(){
        Task {
            do {
                self.receips = try await previewRepo.searchReceipes("").results
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    func searchReceips(){
        Task {
            do {
                self.receips = try await previewRepo.searchReceipes(searchString).results
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    func extendedSearch(){
        Task{
            do{
                self.receips = try await previewRepo.extendedSearch(search: searchString, vegan: vegan, glutenFree: glutenFree, excludedIngredients: excludeIngredients).results
            } catch {
                print(error)
            }
        }
    }
}
