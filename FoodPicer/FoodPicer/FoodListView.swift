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
    
    @State private var foodDetailSheetHeight: CGFloat = FoodDetailSheetHeightkey.defaultValue
    @State private var shouldShowSheet: Bool = false
    @State private var foodDetailSheetSelected: Food?
    
    @State private var shouldShowFoodForm: Bool = false
    
    var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    
    var body: some View {
        VStack (alignment: .leading){
            
            titleBar
            
            List($foods, id: \.id, editActions: .all, selection: $selectFoods) { $food in
                HStack {
                    Text(food.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if isEditing {
                                return
                            }
                            foodDetailSheetSelected = food
                            shouldShowSheet = true
                        }
                    Image(systemName: "pencil")
                        .font(.title2.bold())
                        .opacity(isEditing ? 1 : 0)
                        .foregroundColor(.accentColor)
                }
            }
            .listStyle(.plain)
            .padding(.horizontal)
            .scrollIndicators(.hidden)
        }
        .background(.groupbg)
        .safeAreaInset(edge: .bottom, content: buildFloatButton)
        .sheet(isPresented: $shouldShowFoodForm) {
            FoodFormView(food: Food(name: "", image: "")) { food in
                foods.append(food)
            }
        }
        .sheet(isPresented: $shouldShowSheet, content: {
            if let selectedFood = foodDetailSheetSelected {
                HStack (spacing: 30){
                    Text(selectedFood.image)
                        .font(.system(size: 100))
                    
                    Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                        GridRow{
                            Text("蛋白质")
                            Text("碳水" )
                            Text("脂肪")
                        }
                        .frame(minWidth: 60)
                        
                        Divider()
                            .gridCellUnsizedAxes(.horizontal)
                            .padding(.horizontal,-10)
                        GridRow{
                            Text(selectedFood.$protein)
                            Text(selectedFood.$carb)
                            Text(selectedFood.$fat)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.bg))
                    .transition(.move(edge: .top))
                }
                .padding()
    //            .presentationDetents([.medium])
                .overlay {
                    GeometryReader{ proxy in
                        Color.clear.preference(key: FoodDetailSheetHeightkey.self, value: proxy.size.height)
                    }
                }
                .onPreferenceChange(FoodDetailSheetHeightkey.self) {
                    foodDetailSheetHeight = $0
                }
                .presentationDetents([.height(foodDetailSheetHeight)])
            }
        })
    }
}


private extension FoodListView {
    struct FoodDetailSheetHeightkey: PreferenceKey {
        static var defaultValue: CGFloat = 300
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}


private extension FoodListView {
    
    func buildFloatButton() -> some View  {
        ZStack {
            removeButton
                .transition(.move(edge: .leading).combined(with: .opacity)
                    .animation(.easeInOut))
                .opacity(isEditing ? 1 : 0)
                .id(isEditing)
            
            HStack {
                
                Spacer()

                addButton
                    .scaleEffect(isEditing ? 0 : 1)
                    .opacity(isEditing ? 0 : 1)
                    .animation(.easeInOut, value: isEditing)
            }
        }
    }
    
    var titleBar: some View {
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
    }
    
    var addButton: some View {
        Button {
            shouldShowFoodForm = true
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .padding()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, Color.accentColor.gradient)
        }

    }
    
    var removeButton: some View {
        Button {
            withAnimation(.easeOut) {
                foods = foods.filter { !selectFoods.contains($0.id) }
            }
        } label: {
            Text("删除选中")
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .mainButtonStyle(shape: .roundedRectangle(radius: 6))
        .padding(.horizontal,50)
    }
    
}

#Preview {
    FoodListView()
//    FoodListView().environment(\.editMode,.constant(.active))
}
