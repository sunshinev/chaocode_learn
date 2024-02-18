//
//  FoodFormView.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/18.
//

import SwiftUI


private extension FoodListView {
    
    struct FoodFormView: View {
        
        @State var food: Food
        
        var body: some View {
            VStack {
                Label("edit", systemImage: "pencil")
                    .font(.title2.bold())
                
                Form {
                    LabeledContent("名称") {
                        TextField("必填", text: $food.name)
                    }
                    LabeledContent("图示") {
                        TextField("必填", text: $food.image)
                    }
                    LabeledContent("卡路里") {
                        TextField("必填", value: $food.calorie, format: .number.precision(.fractionLength(1)))
                    }
                    LabeledContent("碳水") {
                        TextField("必填", value: $food.carb,format: .number.precision(.fractionLength(1)))
                    }
                    LabeledContent("脂肪") {
                        TextField("必填", value: $food.fat ,format: .number.precision(.fractionLength(1)))
                    }
                    LabeledContent("蛋白质") {
                        TextField("必填", value: $food.protein,format: .number.precision(.fractionLength(1)))
                    }
                }
            }
            .multilineTextAlignment(.trailing)
            .background(.groupbg)
        }
    }
    
}



#Preview {
    FoodListView.FoodFormView(food: Food(name: "", image: ""))
}
