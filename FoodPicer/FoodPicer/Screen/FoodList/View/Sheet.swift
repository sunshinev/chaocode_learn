//
//  Sheet.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/25.
//

import SwiftUI

extension FoodListScreen {
    enum Sheet: View, Identifiable {
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
                FoodListScreen.FoodFormView(food: .new, onSubmit: onSubmit)
            case .editFood(let binding):
                FoodListScreen.FoodFormView(food: binding.wrappedValue) { binding.wrappedValue = $0 }
            case .foodDetail(let food):
                FoodListScreen.FoodDetailSheet(selectedFood: food)
            }
        }
    }
    
}
