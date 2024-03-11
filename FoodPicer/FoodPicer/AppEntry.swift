//
//  FoodPicerApp.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/5.
//

import SwiftUI

@main
struct AppEntry: App {
    
    init() {
        applyTabBarBacground()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
    }
    
    func applyTabBarBacground() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.3)
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}

