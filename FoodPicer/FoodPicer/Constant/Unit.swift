//
//  Unit.swift
//  FoodPicer
//
//  Created by jaysun on 2024/3/5.
//

import SwiftUI


protocol MyUnitProtocol:  Codable, Identifiable, CaseIterable, View, Hashable,Equatable, RawRepresentable where RawValue == String, AllCases: RandomAccessCollection {
    static var userDefaultsKey: UserDefaults.Key { get }
    static var defaultUnit: Self { get }
    
    associatedtype T: Dimension
    
    var dimension: T {
        get
    }
}


extension MyUnitProtocol {
    var id: Self { self }
    
    var body: some View {
        Text(rawValue)
    }
}


extension MyUnitProtocol {
    static func getPreferredUnit() -> Self {
        AppStorage(userDefaultsKey).wrappedValue
    }
}

enum MyWeightUnit: String, MyUnitProtocol {
    static var userDefaultsKey: UserDefaults.Key = .preferredWeightUnit
    
    static var defaultUnit: MyWeightUnit = .gram
    
    var dimension: UnitMass {
        switch self {
        case .gram: return .grams
        case .pound: return .pounds
        }
    }
    
    case gram = "g", pound="lb"
}

enum MyEnergyUnit: String, MyUnitProtocol {
    static var userDefaultsKey: UserDefaults.Key = .preferredEnergyUnit
    
    static var defaultUnit: MyEnergyUnit = .cal
    
    var dimension: UnitEnergy {
        switch self {
        case .cal: return .calories
        }
    }

    case cal = "大卡"
}
