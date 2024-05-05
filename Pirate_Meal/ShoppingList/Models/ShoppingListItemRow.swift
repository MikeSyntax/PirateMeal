//
//  PreviewShoppingListRepository.swift
//  Pirate_Meal
//
//  Created by Mike Reichenbach on 21.02.24.
//

import SwiftUI

struct ShoppingListItemRow: View {
    
    @Binding var item: ShoppingListItem
    
    
    var body: some View {
        HStack{
            Button(action: {
                item.checked.toggle()
            }){
                Image(systemName: item.checked ? "checkmark.circle.fill":"circle")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(item.checked ? Color.green: Color.black)
            }
            Text(item.name)
                .strikethrough(item.checked, color: .black)
                
            Text(item.quantity.formatted())
            Text(item.unit)
            
        }
    }
}

#Preview {
    ShoppingListItemRow(item: .constant(ShoppingListItem(id: 0, name: "Jack Daniels", quantity: 2, unit: "Fl", checked: true)))
}
