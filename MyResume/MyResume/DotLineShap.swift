//
//  DotLineShap.swift
//  MyResume
//
//  Created by jaysun on 2024/1/23.
//

import SwiftUI

struct DotLineShap: Shape {
    
    enum LineStyle {
        case full
        case bottomHalf
        case topHalf
    }
    
    var circleRadio: CGFloat
    var rectWidth: CGFloat
    var style: LineStyle
    
    init(circleRadio: CGFloat = 4, rectWidth: CGFloat = 2, style: LineStyle = LineStyle.full) {
        self.circleRadio = circleRadio
        self.rectWidth = rectWidth
        self.style = style
    }
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        path.addEllipse(in: CGRect(
            x: rect.midX - circleRadio,
            y: style == .full ? rect.midY - circleRadio : style == .bottomHalf ? (rect.maxY*0.2) - circleRadio : (rect.maxY*0.8) - circleRadio,
            width: circleRadio*2,
            height: circleRadio*2))
        path.addRect(CGRect(
            x: rect.midX - rectWidth/2,
            y: style == .bottomHalf ? rect.maxY * 0.2: rect.minY,
            width: rectWidth,
            height: style == LineStyle.full ? rect.height : rect.height * 0.8))
        
        
        return path
    }
}

#Preview {
    VStack (spacing: 0){
        DotLineShap(style: .bottomHalf)
            .background(.yellow)
        DotLineShap()
            .background(.blue)
        DotLineShap(style: .topHalf)
            .background(.yellow)
    }
//    .frame(height: 500)
}
