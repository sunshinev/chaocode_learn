//
//  File.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/25.
//

import Foundation

@propertyWrapper struct Suffix: Equatable {
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


extension Suffix: Codable {}
