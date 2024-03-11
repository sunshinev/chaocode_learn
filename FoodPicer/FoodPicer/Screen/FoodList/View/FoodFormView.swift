//
//  FoodFormView.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/18.
//

import SwiftUI


extension FoodListScreen {
    
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
                    Label("edit", systemImage: .pencil)
                        .font(.title2.bold())
                        .push(.leading)
                        .foregroundColor(.accentColor)
                        
                    Image(systemName: .xmark)
                        .font(.title2)
                        .onTapGesture {
                            dismiss()
                        }
                }
                .padding([.horizontal,.top])
                
                Form(content: {
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
                    
                    buildLabledContent(title:"热量", value: $food.$calorie, suffix:"kcal")
                        .submitLabel(.next)
                        .focused($field,equals: .calories)
                        .onSubmit {
                            field = .carb
                        }
                    buildLabledContent(title:"碳水", value:$food.$carb,suffix:"g")
                        .submitLabel(.next)
                        .focused($field,equals: .carb)
                        .onSubmit {
                            field = .fat
                        }
                    buildLabledContent(title:"脂肪", value:$food.$fat,suffix:"g")
                        .submitLabel(.next)
                        .focused($field,equals: .fat)
                        .onSubmit {
                            field = .protein
                        }
                    buildLabledContent(title:"蛋白质", value:$food.$protein,suffix:"g")
                        .focused($field,equals: .protein)
                })
                
                Button {
                    dismiss()
                    onSubmit(food)
                } label: {
                    Text(buttonUnValidMessage ?? "保存")
                        .push(.center)
                }
                .mainButtonStyle()
                .padding()
                .disabled(isButtonValid)

            }
            .multilineTextAlignment(.trailing)
            .background(.groupbg)
//            .scrollDismissesKeyboard(.interactively)
        }
        
        private func buildLabledContent<Unit: MyUnitProtocol>(title: String, value: Binding<Suffix<Unit>>, suffix: String) -> some View {
            LabeledContent(title) {
                HStack{
                    TextField("必填",value: Binding(
                        get: { value.wrappedValue.wrappedValue},
                        set: { value.wrappedValue.wrappedValue = $0 }
                    ),format: .number.precision(.fractionLength(1))
                    )
                    .keyboardType(.numbersAndPunctuation)
                    
                    if Unit.allCases.count <= 1 {
                        value.unit.wrappedValue
                    }else {
                        Picker("单位", selection: value.unit) {
                            ForEach(Unit.allCases, id: \.self) {$0}
                        }
                        .labelsHidden()
                    }
                    
                    Text(suffix)
                }
            }
        }
    }
}



#Preview {
    FoodListScreen.FoodFormView(food: Food(name: "", image: "", calorie: 10, carb: 10, fat: 10, protein: 10)) { _ in }
}
