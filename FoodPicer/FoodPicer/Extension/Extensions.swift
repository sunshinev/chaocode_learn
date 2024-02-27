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


extension View {
    func mainButtonStyle(shape: ButtonBorderShape = .capsule) -> some View {
        buttonStyle(.borderedProminent)
            .buttonBorderShape(shape)
            .controlSize(.large)
    }
    
    func sheet(item: Binding<(some View & Identifiable)? >) -> some View{
        sheet(item: item) { $0 }
    }
    
    func push(_ alignment: TextAlignment) -> some View {
        switch alignment {
        case .leading:
            return frame(maxWidth: .infinity, alignment: .leading)
        case .center:
            return frame(maxWidth: .infinity, alignment: .center)
        case .trailing:
            return frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
