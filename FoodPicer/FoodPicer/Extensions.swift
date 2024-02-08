//
//  extensions.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/6.
//

import SwiftUI


extension ShapeStyle where Self == Color {
    static var bg: Color {
        Color(.systemBackground)
    }
    
    static var bg2: Color {
        Color(.secondarySystemBackground)
    }
    static var groupbg: Color {
        Color(.systemGroupedBackground)
    }
}

extension ContentView {
    
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
    
    func WhatToEat() -> some View {
        Text("今天吃什么呢？")
            .font(.largeTitle)
            .bold()
    }
    
    @ViewBuilder
    func FoodShow() -> some View {
        if let selectedFood {
            HStack{
                Text(selectedFood.name)
                    .font(.largeTitle)
                    .transition(.opacity)
                    .foregroundColor(.green)
                    .padding()
                Image(systemName: "info.circle.fill")
                    .font(.title2)
                    .onTapGesture {
                        withAnimation(.spring(dampingFraction:  0.5)) {
                            isShowDetail.toggle()
                        }
                    }
            }
        }
    }
    
    
    func FoodDetail() -> some View {
        VStack {
            if selectedFood != .none && isShowDetail {
                Text("热量\(selectedFood!.$calorie)")
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
                        Text(selectedFood!.$protein)
                        Text(selectedFood!.$carb)
                        Text(selectedFood!.$fat)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.bg))
                .transition(.move(edge: .top))
            }
        }
    }
    
    
    func FoodButton() -> some View {
        Group {
            Button {
                withAnimation(.easeInOut(duration: 1)) {
                    selectedFood =  foods.shuffled().first{ $0 != selectedFood }
                }
            } label: {
                Text(selectedFood == .none ? "choose one":"next one")
                    .animation(.none, value: selectedFood)
                    .transformEffect(.identity)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            Button(role: .none) {
                selectedFood = .none
            } label: {
                Text("reset")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .font(.title2)
    }
}
