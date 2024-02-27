//
//  HomeScreen.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/26.
//

import SwiftUI

struct HomeScreen: View {
    
    enum Tab: View, CaseIterable {
        case picker, list
        
        var body: some View {
            content.tabItem { tabLabel }
        }
        
        @ViewBuilder
        private var content: some View {
            switch self {
            case .picker: 
                FoodPickerScreen()
            case .list:
                FoodListScreen()
            }
        }
        
        private var tabLabel: some View {
            switch self {
            case .picker:
                return Label("Home",systemImage: .house)
            case .list:
                return Label("Home",systemImage: .list)
            }
        }
    }
    
    var body: some View {
        TabView {
            ForEach(Tab.allCases, id: \.self) { $0 }
        }
    }
}

#Preview {
    HomeScreen()
}
