//
//  FoodListView.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/8.
//

import SwiftUI

extension [Food]: RawRepresentable {
    
    public init?(rawValue: String) {
        if let data = rawValue.data(using: .utf8) {
            if let array = try? JSONDecoder().decode([Food].self,from: data) {
                self = array
                return
            }
        }
        
        print("[Food] init failed, rawValue is \(rawValue)")
        
        return nil
    }
    
    public var rawValue: String {
        if let data = try? JSONEncoder().encode(self) {
            print("[Food] rawValue data is \(data)")
            return String(data: data, encoding: .utf8) ?? ""
        }else{
            return ""
        }
    }
    
}


struct FoodListScreen: View {
    
    @AppStorage(.foodList) private var foods = Food.examples
    
    @State private var editMode: EditMode = .inactive
    @State var selectFoodIDSet = Set<Food.ID>()
    @State private var sheet: Sheet?
    
    
    
    var isEditing: Bool {
        editMode.isEditing
    }
    
    var body: some View {
        VStack (alignment: .leading){
            
            titleBar
        
            List($foods, editActions: .all, selection: $selectFoodIDSet, rowContent: buildFoodRow)
            .listStyle(.plain)
            .padding(.horizontal)
            .scrollIndicators(.hidden)
        }
        .background(.groupbg)
        .safeAreaInset(edge: .bottom, content: buildFloatButton)
        .environment(\.editMode, $editMode)
        .sheet(item: $sheet)
    }
    
    func buildFoodRow(_ bindingFood: Binding<Food>) -> some View {
        let food = bindingFood.wrappedValue
        
        return HStack {
            Text(food.name)
                .push(.leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    if isEditing {
                        selectFoodIDSet.insert(food.id)
                        return
                    }
                    sheet = .foodDetail(food)
                }
            
            Image(systemName: .pencil)
                .font(.title2.bold())
                .opacity(isEditing ? 1 : 0)
                .foregroundColor(.accentColor)
                .onTapGesture {
                    sheet = .editFood(bindingFood)
                }
        }
    }
}




// MARK: button
extension FoodListScreen {
    
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
                icon: { Image(systemName: .forkAndKnife) }
            )
            .font(.title.bold())
            .foregroundColor(.accentColor)
            .push(.leading)
            
            EditButton()
                .buttonStyle(.bordered)
        }
        .padding()
    }
    
    var addButton: some View {
        Button {
            sheet = .newFood{ foods.append($0) }
        } label: {
            Image(systemName: .plus)
                .font(.system(size: 50))
                .padding()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, Color.accentColor.gradient)
        }

    }
    
    var removeButton: some View {
        Button {
            withAnimation(.easeOut) {
                foods = foods.filter { !selectFoodIDSet.contains($0.id) }
            }
        } label: {
            Text("删除选中")
                .push(.center)
        }
        .mainButtonStyle(shape: .roundedRectangle(radius: 6))
        .padding(.horizontal,50)
    }
}



#Preview {
    FoodListScreen()
}
