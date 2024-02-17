//
//  FoodListView.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/8.
//

import SwiftUI

struct FoodListView: View {
    
    @Environment(\.editMode) var editMode
    
    @State private var foods = Food.examples
    @State private var selectFoods: Set<UUID> = []
    
    var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    
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
        .safeAreaInset(edge: .bottom) {
            HStack {
                addButton
                    .opacity(isEditing ? 0 : 1)
                removeButton
                    .opacity(isEditing ? 1 : 0)
            }
        }
    }
    
    
    var addButton: some View {
        Button(role: .none) {
            
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 30))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .blue)
        }
        .padding()
    }
    
    var removeButton: some View {
        Button(role: .none) {
            foods = foods.filter { !selectFoods.contains($0.id) }
        } label: {
            Text("删除选中")
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
        }

    }
}


#Preview {
    FoodListView().environment(\.editMode,.constant(.active))
}
