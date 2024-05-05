//
//  PreviewShoppingListRepository.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 21.02.24.
//

import SwiftUI

struct ReceipDetailView: View {
    
    @ObservedObject var vm: ReceipDetailViewModel
    let updateShoppingList: ()->()
    
    var body: some View {
        ScrollView{
            AsyncImage(url: URL(string: vm.image)){image in
                image
                    .resizable()
                    .frame(width: 300, height: 300)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .padding(4)
                    .background(LinearGradient(colors: [.yellow, .gray], startPoint: .bottomLeading, endPoint: .topTrailing))
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }placeholder: {
                ProgressView()
            }.padding()
            
            Text(vm.title)
                .font(.title3)
                .bold()
                .padding()
            HStack{
                Text("Zutaten")
                    .font(.title3)
                    .bold()
                    .padding()
                Spacer()
            }
            VStack{
                ForEach(vm.ingredients, id:  \.id){ingredient in
                        IngredientRow(ingredient: ingredient)
                }
            }
            
            Button(action: {
                
                vm.addIngredientsToShoppingList()
                updateShoppingList()
                
            }){
                
                Text("Zutaten zur Einkaufsliste hinzufügen")
                
            }.buttonStyle(.borderedProminent)
            
            
            Text(vm.instruction)
                .padding()
                .padding(.top, 20)
            
            
            
        }
        .onAppear {
            vm.loadDetails()
        }
    }
}

#Preview {
    ReceipDetailView(vm: ReceipDetailViewModel(receip:
                                                Receip(id: 716429, title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs", image: "https://spoonacular.com/recipeImages/716429-312x231.jpg")
                                              ), updateShoppingList: {})
}
