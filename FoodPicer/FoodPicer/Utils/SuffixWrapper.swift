//
//  File.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/25.
//

import Foundation

@propertyWrapper struct Suffix<Unit: MyUnitProtocol>: Equatable {
    var wrappedValue: Double
    
    var unit: Unit

    init(wrappedValue: Double, _ unit: Unit) {
        self.wrappedValue = wrappedValue
        self.unit = unit
    }
    
    var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
    
    var description: String {
        
        let preferredUnit = Unit.getPreferredUnit()
        let measurement = Measurement(value: wrappedValue, unit: unit.dimension)
        let converted = measurement.converted(to: preferredUnit.dimension)
        
        return converted.value.formatted(.number.precision(.fractionLength(0...1))) + " \(preferredUnit.rawValue)"
    }
}


extension Suffix: Codable {}
