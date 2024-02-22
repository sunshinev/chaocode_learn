//
//  FoodListView.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/8.
//

import SwiftUI


private enum Sheet: View, Identifiable {
    case newFood((Food)->Void)
    case editFood(Binding<Food>)
    case foodDetail(Food)
    
    
    var id : UUID {
        switch self {
        case .newFood(_):
            return UUID()
        case .editFood(let binding):
            return binding.wrappedValue.id
        case .foodDetail(let food):
            return food.id
        }
    }
    
    
    var body: some View {
        switch self {
        case .newFood(let onSubmit):
            FoodListView.FoodFormView(food: .new, onSubmit: onSubmit)
        case .editFood(let binding):
            FoodListView.FoodFormView(food: binding.wrappedValue) { binding.wrappedValue = $0 }
        case .foodDetail(let food):
            FoodListView.FoodDetailSheet(selectedFood: food)
        }
    }
}
    
struct FoodListView: View {
    
    @Environment(\.editMode) var editMode
    
    @State private var foods = Food.examples
    @State private var selectFoods: Set<UUID> = []
    @State private var sheet: Sheet?
    
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
                            sheet = .foodDetail(food)
                        }
                    Image(systemName: "pencil")
                        .font(.title2.bold())
                        .opacity(isEditing ? 1 : 0)
                        .foregroundColor(.accentColor)
                        .onTapGesture {
                            sheet = .editFood($food)
                        }
                }
            }
            .listStyle(.plain)
            .padding(.horizontal)
            .scrollIndicators(.hidden)
        }
        .background(.groupbg)
        .safeAreaInset(edge: .bottom, content: buildFloatButton)
        .sheet(item: $sheet) { $0 }
    }
}


private extension FoodListView {
    
    struct DetailSheetHeightkey: PreferenceKey {
        static var defaultValue: CGFloat = 300
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
    
    struct FoodDetailSheet: View {
        @State private var foodDetailSheetHeight: CGFloat = FoodListView.DetailSheetHeightkey.defaultValue
        
        let selectedFood: Food
        
        var body: some View {
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
                    Color.clear.preference(key: FoodListView.DetailSheetHeightkey.self, value: proxy.size.height)
                }
            }
            .onPreferenceChange(FoodListView.DetailSheetHeightkey.self) {
                foodDetailSheetHeight = $0
            }
            .presentationDetents([.height(foodDetailSheetHeight)])
        
        }
    }
    
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
            sheet = .newFood{ foods.append($0) }
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
}
