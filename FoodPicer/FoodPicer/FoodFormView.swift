//
//  FoodFormView.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/18.
//

import SwiftUI


extension FoodListView {
    
    struct FoodFormView: View {
        
        @Environment(\.dismiss) var dismiss
        
        private enum MyField: Int {
            case title, image, carb, calories, protein, fat
        }

        @FocusState private var field: MyField?
        
        @State var food: Food
        private var isButtonValid: Bool {
            food.name.isEmpty || food.image.count > 2
        }
        
        var onSubmit: (Food) -> Void
        
        private var buttonUnValidMessage: String? {
            if food.name.isEmpty { return "名称不能为空" }
            if food.image.count > 2 { return "图示数量>2" }
            return .none
        }
        
        
        var body: some View {
            VStack {
                HStack{
                    Label("edit", systemImage: "pencil")
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.accentColor)
                        
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .onTapGesture {
                            dismiss()
                        }
                }
                .padding([.horizontal,.top])
                
                Form {
                    LabeledContent("名称") {
                        TextField("必填", text: $food.name)
                            .submitLabel(.next)
                            .focused($field,equals: .title)
                            .onSubmit {
                                field = .image
                            }
                    }
                    LabeledContent("图示") {
                        TextField("必填", text: $food.image)
                            .submitLabel(.next)
                            .focused($field,equals: .image)
                            .onSubmit {
                                field = .calories
                            }
                    }
                    
                    buildLabledContent(title:"热量", value:$food.calorie,suffix:"kcal")
                        .submitLabel(.next)
                        .focused($field,equals: .calories)
                        .onSubmit {
                            field = .carb
                        }
                    buildLabledContent(title:"碳水", value:$food.carb,suffix:"g")
                        .submitLabel(.next)
                        .focused($field,equals: .carb)
                        .onSubmit {
                            field = .fat
                        }
                    buildLabledContent(title:"脂肪", value:$food.fat,suffix:"g")
                        .submitLabel(.next)
                        .focused($field,equals: .fat)
                        .onSubmit {
                            field = .protein
                        }
                    buildLabledContent(title:"蛋白质", value:$food.protein,suffix:"g")
                        .focused($field,equals: .protein)
                }
                
                Button {
                    dismiss()
                    onSubmit(food)
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
//            .scrollDismissesKeyboard(.interactively)
        }
        
        private func buildLabledContent(title: String, value: Binding<Double>, suffix: String) -> some View {
            LabeledContent(title) {
                HStack{
                    TextField("必填", value: value,format: .number.precision(.fractionLength(1)))
                        .keyboardType(.numbersAndPunctuation)
                    Text(suffix)
                }
            }
        }
    }
}



#Preview {
    FoodListView.FoodFormView(food: Food(name: "", image: "")) { _ in }
}
