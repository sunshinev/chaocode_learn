//
//  Food.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/5.
//

import Foundation


struct Food: Hashable {
    
    var name: String
    var image: String
    let id = UUID()
    
    @Suffix("kcal") var calorie: Double = .zero
    @Suffix("g") var carb: Double = .zero
    @Suffix("g") var fat: Double = .zero
    @Suffix("g") var protein: Double = .zero
    

    static let examples = [
        Food(name: "玉米", image: "🌽", calorie: 1.2, carb: 2, fat: 3, protein: 3.0),
        Food(name: "汉堡", image: "🍔", calorie: 2, carb: 2.6, fat: 3, protein: 7.9),
        Food(name: "薯条", image: "🍟", calorie: 3.8, carb: 2, fat: 3.7, protein: 3),
        Food(name: "米饭", image: "🍚", calorie: 4, carb: 2.5, fat: 3, protein: 1.0),
    ]
}



@propertyWrapper struct Suffix: Hashable {
    var wrappedValue: Double
    
    private let suffix: String
    
    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }
    
    var projectedValue: String {
        wrappedValue.formatted() + "\(suffix)"
    }
}
