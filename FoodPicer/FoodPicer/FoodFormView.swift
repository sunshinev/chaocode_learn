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
        
        private var isButtonValid: Bool {
            food.name.isEmpty || food.image.count > 2
        }
        
        private var buttonUnValidMessage: String? {
            if food.name.isEmpty { return "名称不能为空" }
            if food.image.count > 2 { return "图示数量>2" }
            return .none
        }
        
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
                    
                    buildLabledContent(title:"热量", value:$food.calorie,suffix:"kcal")
                    buildLabledContent(title:"碳水", value:$food.carb,suffix:"g")
                    buildLabledContent(title:"脂肪", value:$food.fat,suffix:"g")
                    buildLabledContent(title:"蛋白质", value:$food.protein,suffix:"g")
                }
                
                Button {
                    
                } label: {
                    Text(buttonUnValidMessage ?? "保存")
                        .frame(maxWidth: .infinity)
                }
                .mainButtonStyle()
                .padding()
                .disabled(isButtonValid)

            }
            .multilineTextAlignment(.trailing)
            .background(.groupbg)
        }
        
        private func buildLabledContent(title: String, value: Binding<Double>, suffix: String) -> some View {
            LabeledContent(title) {
                HStack{
                    TextField("必填", value: value,format: .number.precision(.fractionLength(1)))
                    Text(suffix)
                }
            }
        }
    }
}



#Preview {
    FoodListView.FoodFormView(food: Food(name: "", image: ""))
}
