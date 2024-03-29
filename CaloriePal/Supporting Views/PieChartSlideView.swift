//
//  PieChartSlideView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

public struct PieChartSlideView: View {
    @State private var show: Bool = false
    
    var geometry: GeometryProxy
    var slideData: PieChartSlideData
    var index: Int
    
    var path: Path {
        let chartSize = geometry.size.width
        let radius = chartSize / 2
        let centerX = radius + slideData.deltaX
        let centerY = radius + slideData.deltaY
        
        var path = Path()
        path.move(to: CGPoint(x: centerX, y: centerY))
        path.addArc(center: CGPoint(x: centerX, y: centerY),
                    radius: radius,
                    startAngle: slideData.startAngle,
                    endAngle: slideData.endAngle,
                    clockwise: false)
        return path
    }
    
    public var body: some View {
        path.fill(slideData.data.color)
            .overlay(path.stroke(Color.white, lineWidth: 1))
            .scaleEffect(self.show ? 1 : 0)
            .animation(
                Animation.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3)
                    .delay(Double(self.index) * 0.03)
        ).onAppear() {
            self.show = true
        }
    }
}

struct PieChartSlideView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            PieChartSlideView(geometry: geometry,
                          slideData: PieChartSlideData(startAngle: .degrees(-70), endAngle: .degrees(0)),
                          index: 1)
        }
    }
}
