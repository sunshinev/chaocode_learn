//
//  HomeScreen.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/26.
//

import SwiftUI


struct HomeScreen: View {
    @AppStorage(.shouldUseDarkMode) private var shouldUserDarkMode = false
    @State var tab: Tab = {
//        let rawValue = UserDefaults.standard.string(forKey: UserDefaults.Key.startTab.rawValue) ?? ""
//        return Tab(rawValue: rawValue) ?? .picker
        @AppStorage(.startTab) var tab = HomeScreen.Tab.picker
        return tab
    }()
    
    var body: some View {
        NavigationStack {
            TabView (selection: $tab){
                ForEach(Tab.allCases, id: \.self) { $0 }
            }
            .preferredColorScheme(shouldUserDarkMode ? .dark : .light)
        }
    }
}

extension HomeScreen {
    enum Tab: String, View, CaseIterable {
        case picker, list, setting
        
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
            case .setting:
                SettingScreen()
            }
        }
        
        private var tabLabel: some View {
            switch self {
            case .picker:
                return Label("Home",systemImage: .house)
            case .list:
                return Label("List",systemImage: .list)
            case .setting:
                return Label("Setting",systemImage: .gear)
            }
        }
    }
    
}

#Preview {
    HomeScreen()
}
