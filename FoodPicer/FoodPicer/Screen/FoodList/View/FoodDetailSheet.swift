//
//  FoodDetailSheet.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/25.
//

import SwiftUI


// MARK: Sheet
extension FoodListScreen {
    struct DetailSheetHeightkey: PreferenceKey {
        static var defaultValue: CGFloat = 300
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
    struct FoodDetailSheet: View {
        @State private var foodDetailSheetHeight: CGFloat = FoodListScreen.DetailSheetHeightkey.defaultValue
        
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
                .push(.center)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.bg))
                .transition(.move(edge: .top))
            }
            .padding()
            .overlay {
                GeometryReader{ proxy in
                    Color.clear.preference(key: FoodListScreen.DetailSheetHeightkey.self, value: proxy.size.height)
                }
            }
            .onPreferenceChange(FoodListScreen.DetailSheetHeightkey.self) {
                foodDetailSheetHeight = $0
            }
            .presentationDetents([.height(foodDetailSheetHeight)])
        
        }
    }
}

