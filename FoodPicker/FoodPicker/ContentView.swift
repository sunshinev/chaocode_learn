//
//  ContentView.swift
//  FoodPicker
//
//  Created by jaysun on 2024/1/30.
//

import SwiftUI




struct ContentView: View {
    let food:[String] = (0...127).map { "food_\($0)" }
    
    @State private var selectedFood: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Image("dinner")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("eat what today?")
                .font(.largeTitle.bold())
            
            if selectedFood != "" {
                Text(selectedFood ?? "")
                    .font(.largeTitle)
                    .id(selectedFood)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.easeInOut(duration: 0.5).delay(0.2)),
                        removal: .opacity.animation(.easeIn(duration: 0.4))))
            }
            
            
            Button {
                withAnimation {
                    selectedFood = food.shuffled().first
                }
            } label: {
                Text(selectedFood == .none ? "Tell Me" : "Next one")
                    .frame(width: 200)
                    .animation(.none, value: selectedFood)
                    .transformEffect(.identity)
            }

            Button(action: {
                selectedFood = .none
            }, label: {
                Text("Reset")
                    .frame(width: 200)
            })
            .buttonStyle(.bordered)
        }
        .padding()
        .font(.title)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .frame(maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        
        
    }
}

#Preview {
    ContentView()
}
