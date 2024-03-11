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
        GeometryReader{proxy in
            ScrollView {
                VStack {
                    ImageShow()
                    
                    Text("今天吃什么呢？")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    selectedFoodShow
                    
                    Spacer()
                    
                    selectButton
                    resetButton
                }
                .frame(minHeight: proxy.size.height)
                .mainButtonStyle()
                .padding()
            }
            .scrollIndicators(.hidden)
            .background(.bg2)
        }
    }
}


extension FoodPickerScreen {
    init(selectedFood: Food) {
        _selectedFood = State(wrappedValue: selectedFood)
    }
}


extension FoodPickerScreen {

    func ImageShow() -> some View {
        Group {
            if selectedFood != .none {
                Text(selectedFood!.image)
                    .font(.system(size: 300))
                    .minimumScaleFactor(0.2)
                    .lineLimit(1)
            }else {
                Image("dinner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(height: 300)
    }
    
    @ViewBuilder
    var selectedFoodShow: some View {
        if let selectedFood {
            FoodShow()
            Text("热量\(selectedFood.$calorie.description)")
            FoodDetail()
        }
    }
    
    @ViewBuilder
    func FoodShow() -> some View {
        
        HStack{
            Text(selectedFood!.name)
                .font(.largeTitle)
                .transition(.opacity)
                .foregroundColor(.green)
                .padding()
            Image(systemName: .info)
                .font(.title2)
                .onTapGesture {
                    withAnimation(.spring(dampingFraction:  0.5)) {
                        isShowDetail.toggle()
                    }
                }
        }
    
    }
    
    func FoodDetail() -> some View {
        VStack {
            if isShowDetail {
                Grid{
                    GridRow{
                        Text("蛋白质")
                        Text("碳水" )
                        Text("脂肪")
                    }
                    Divider()
                        .gridCellUnsizedAxes(.horizontal)
                        .padding(.horizontal,-10)
                    GridRow{
                        Text(selectedFood!.$protein.description)
                        Text(selectedFood!.$carb.description)
                        Text(selectedFood!.$fat.description)
                    }
                }
                .push(.center)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.bg))
                .transition(.move(edge: .top))
            }
        }
    }
    
    var selectButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 1)) {
                selectedFood =  foods.shuffled().first{ $0 != selectedFood }
            }
        } label: {
            Text(selectedFood == .none ? "choose one":"next one")
                .animation(.none, value: selectedFood)
                .transformEffect(.identity)
                .push(.center)
        }
        .buttonStyle(.borderedProminent)
    }
    
    var resetButton: some View {
        Button(role: .none) {
            selectedFood = .none
        } label: {
            Text("reset")
                .push(.center)
        }
        .buttonStyle(.bordered)
    }
    
    
    func FoodButton() -> some View {
        Group {
        }
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .font(.title2)
    }
    

}


#Preview {
    
    FoodPickerScreen()
}
