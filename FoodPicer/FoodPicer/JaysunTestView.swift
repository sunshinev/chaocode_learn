//
//  JaysunTestView.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/24.
//

import SwiftUI

struct JaysunTestView: View {
    var body: some View {
        HStack {
            Text("Hello, World!")
            
            childView()
        }
    }
    
    struct JaysunTest: View {
        var body: some View {
            Text("jaysun")
        }
    }
}

extension JaysunTestView {
    struct childView: View {
        var body: some View {
            JaysunTestView.JaysunTest()
        }
    }
}

#Preview {
    JaysunTestView()
}
