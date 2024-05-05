//
//  PreviewShoppingListRepository.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 21.02.24.
//

import SwiftUI

struct MainScreenView: View {
    
    @State var currentTab = 1
    @StateObject private var shoppingVM = ShoppingListViewModel()
    
    var body: some View {
        TabView(selection: $currentTab) {
            BrowseReceipView(updateList: shoppingVM.getItems)
                .tabItem {
                    Image(systemName:
                            currentTab == 1 ?
                          "book":"book.closed")
                    Text("Rezepte")
                }.tag(1)
            
            ShoppingListView(vm: shoppingVM)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Einkaufsliste")
                }.badge(shoppingVM.shoppingList.filter{
                    !$0.checked
                }.count)
                .tag(2)
        }
    }
}

#Preview {
    MainScreenView()
}
