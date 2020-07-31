//
//  PieChartView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct PieChartView: View {
    var pieChartData: PieChartData
    
    var body: some View {
        GeometryReader { geometry in
            self.makePieChart(geometry, slides: self.pieChartData.data)
        }
    }
    
    func makePieChart(_ geometry: GeometryProxy, slides: [PieChartSlideData]) -> some View {
        let chartSize = min(geometry.size.width, geometry.size.height)
        let radius = chartSize / 2
        let centerX = geometry.size.width / 2
        let centerY = geometry.size.height / 2
        
        return ZStack {
            ForEach(0..<slides.count, id: \.self) { index in
                PieChartSlideView(geometry: geometry, slideData: slides[index], index: index)
            }
            ForEach(slides) { slideData in
                Text("\(slideData.annotation)%")
                    .foregroundColor(Color.white)
                    .position(CGPoint(x: centerX + slideData.annotationDeltaX*radius,
                                      y: centerY + slideData.annotationDeltaY*radius))
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(pieChartData: PieChartData(data: [1, 2, 3]))
    }
}
