//
//  ReceipRow.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 19.02.24.
//

import SwiftUI

struct ReceipRow: View {
    
    let receip: Receip
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: receip.image)){image in
                
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                
            }placeholder: {
                ProgressView()
            }
            Text(receip.title)
                .font(.title2)
                .bold()
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            
        }
    }
}

#Preview {
    ReceipRow(receip: Receip(id: 715538, title: "What to make for dinner tonight?? Bruschetta Style Pork & Pasta", image: "https://spoonacular.com/recipeImages/715538-312x231.jpg"))
}
