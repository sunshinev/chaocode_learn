//
//  SFSymbol.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/25.
//

import SwiftUI


enum SFSymbol: String {
    case pencil
    case plus = "plus.circle.fill"
    case xmark = "xmark.circle.fill"
    case forkAndKnife = "fork.knife"
    case info = "info.circle.fill"
}


extension Label where Title == Text, Icon == Image {
    init(_ text: String, systemImage: SFSymbol) {
        self.init(text, systemImage: systemImage.rawValue)
    }
}


extension Image {
    init(systemName: SFSymbol ){    
        self.init(systemName: systemName.rawValue)
    }
}
