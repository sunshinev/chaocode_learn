//
//  FoodListView.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/8.
//

import SwiftUI

struct FoodListView: View {
    
    @State private var foods = Food.examples
    @State private var selectFoods: Set<UUID> = []
    
    var body: some View {
        VStack (alignment:.leading){
            HStack {
                Label(
                    title: { Text("食物清单") },
                    icon: { Image(systemName: "fork.knife") }
                )
                .font(.title.bold())
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                EditButton()
                    .buttonStyle(.bordered)
            }
            .padding()
             
            List($foods, id: \.id, editActions: .all, selection: $selectFoods) { $foods in
                Text(foods.name)
            }
            .listStyle(.automatic)
            .scrollIndicators(.hidden)
        }
        .background(.groupbg)
        .safeAreaInset(edge: .bottom, alignment: .trailing, content: {
            Button(role: .none) {
                
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 50))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .blue)
            }
            .padding()
        })
    }
}

#Preview {
    FoodListView()
}
