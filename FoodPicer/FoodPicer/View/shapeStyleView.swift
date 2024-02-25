//
//  shapeStyleView.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/7.
//

import SwiftUI

struct shapeStyleView: View {
    var body: some View {
        VStack {
            Circle().fill(.teal)
            Circle().fill(.teal.gradient)
            
            Circle().fill(.image(.init("dinner")))
            
            Circle().fill(.linearGradient(colors: [.pink,.indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            Text("Hello World")
                .font(.largeTitle)
                .foregroundStyle(.linearGradient(colors: [.pink,.indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            
            
        }
    }
}

#Preview {
    shapeStyleView()
}
