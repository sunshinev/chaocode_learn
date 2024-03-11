//
//  Food.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/5.
//

import Foundation
import SwiftUI


typealias Weight  = Suffix<MyWeightUnit>
typealias Energy = Suffix<MyEnergyUnit>

struct Food: Equatable, Identifiable {
    
    var name: String
    var image: String
    var id = UUID()
    
    @Energy var calorie: Double
    @Weight var carb: Double
    @Weight var fat: Double
    @Weight var protein: Double
    
}

extension Food  {
    
    init(name: String, image: String, id: UUID = UUID(), calorie: Double, carb: Double, fat: Double, protein: Double) {
        self.name = name
        self.image = image
        self.id = id
        self._calorie = .init(wrappedValue: calorie, .cal)
        self._carb = .init(wrappedValue: carb, .gram)
        self._fat = .init(wrappedValue: fat, .gram)
        self._protein = .init(wrappedValue: protein, .gram)
        
    }

    
    static var examples = [
        Food(name: "玉米", image: "🌽", calorie: 1.2, carb: 2, fat: 3, protein: 3.0),
        Food(name: "汉堡", image: "🍔", calorie: 2, carb: 2.6, fat: 3, protein: 7.9),
        Food(name: "薯条", image: "🍟", calorie: 3.8, carb: 2, fat: 3.7, protein: 3),
        Food(name: "米饭", image: "🍚", calorie: 4, carb: 2.5, fat: 3, protein: 1.0),
    ]
    
    static var new: Food {
        let preferredWeightUnit = MyWeightUnit.getPreferredUnit()
        let preferredEnergyUnit = MyEnergyUnit.getPreferredUnit()
        
        return Food(
            name: "",
            image: "",
            calorie: .init(wrappedValue: .zero, preferredEnergyUnit),
            carb: .init(wrappedValue: .zero,preferredWeightUnit),
            fat: .init(wrappedValue: .zero,preferredWeightUnit),
            protein: .init(wrappedValue: .zero,preferredWeightUnit)
        )
    }
}



extension Food: Codable {}
