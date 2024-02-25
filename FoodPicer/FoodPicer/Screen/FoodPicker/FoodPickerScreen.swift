//
//  ContentView.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/5.
//

import SwiftUI

struct FoodPickerScreen: View {
    
    @State var selectedFood: Food?
    @State var isShowDetail = true
    
    let foods = Food.examples
    
    var body: some View {
        ScrollView {
            VStack {
                ImageShow()
                
                WhatToEat()
                
                FoodShow()
                
                Spacer()
                
                FoodDetail()
                
                Spacer()
                
                FoodButton()
            }
            .padding()
        }
    }
}


extension FoodPickerScreen {
    init(selectedFood: Food) {
        _selectedFood = State(wrappedValue: selectedFood)
    }
}


#Preview {
    
    FoodPickerScreen()
}
