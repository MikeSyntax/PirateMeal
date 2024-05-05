//
//  BrowseReceipViewModel.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 19.02.24.
//

import SwiftUI

struct BrowseReceipView: View {
    
    @StateObject var viewModel = BrowseRecipeViewModel()
    let updateList: ()->()
    
    var body: some View {
        NavigationStack{
            Button(action: {
                viewModel.searchIsVisible.toggle()
            }, label: {
                Text("Search")
            })
            if viewModel.searchIsVisible{
                VStack{
                    HStack{
                        TextField("search", text: $viewModel.searchString)
                            .padding()
                            .textFieldStyle(.roundedBorder)
                        
                        Button(action: {
                            viewModel.extendedSearch()
                        }, label: {
                            Image(systemName: "magnifyingglass.circle")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .padding(2)
                                .background(
                                    Circle()
                                        .foregroundStyle(AngularGradient(colors: [.gray,.black], center: .center))
                                )
                                .foregroundStyle(AngularGradient(colors: [.white,.gray], center: .center))
                                .padding(.trailing)
                        })
                    }
                    
                    HStack{
                        Text("ohne")
                            .padding(.leading)
                        TextField("z.B. eggs, nuts",text:  $viewModel.excludeIngredients)
                            .textFieldStyle(.plain)
                            .padding(.horizontal)
                    }
                    HStack{
                        Button(action: {
                            viewModel.vegan.toggle()
                        }, label: {
                            Image(systemName: viewModel.vegan ? "circle.circle.fill":"circle")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .foregroundColor(viewModel.vegan ? Color.green: Color.black)
                        })
                        .padding(.leading)
                        Text("vegan")
                        Spacer()
                        
                        Button(action: {
                            viewModel.glutenFree.toggle()
                        }, label: {
                            Image(systemName: viewModel.glutenFree ? "circle.circle.fill":"circle")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .foregroundColor(viewModel.glutenFree ? Color.green: Color.black)
                        })
                        Text("Gluten frei")
                        Spacer()
                    }
                    
                }
            }
            List(viewModel.receips, id: \.id){ receip in
                
                NavigationLink(destination: ReceipDetailView(vm: ReceipDetailViewModel(receip: receip), updateShoppingList: updateList)){
                    
                    ReceipRow(receip: receip)
                }
                
                
            }.onAppear{
                viewModel.loadReceips()
            }.navigationTitle("Rezepte")
        }
    }
}

#Preview {
    BrowseReceipView( updateList: {})
}
