//
//  BarChartView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/6/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct BarChartView: View {
    var data: [[Float]]
    var tags: [String]
    var colors: [Color]
    var showOverflow: Bool
    
    init(data: [[Float]], tags: [String], colors: [Color], showOverflow: Bool=false) {
//        if showOverflow {
//            self.data = BarChartView.scaleData(data: data)
//        } else {
            self.data = data
//        }
        self.tags = tags
        self.colors = colors
        self.showOverflow = showOverflow
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                HStack {
                    Spacer(minLength: 0.0)
                    ForEach(0..<self.data.count, id: \.self) { idx in
                        BarView(data: self.data[idx], tag: self.tags[idx], colors: self.colors)
                            .frame(width: BarChartView.barWidth)
                    }
                    Spacer(minLength: 0.0)
                }
                if self.showOverflow {
                    Rectangle()
                        .foregroundColor(.red)
                        .opacity(0.1)
                        .frame(width: BarChartView.barWidth * CGFloat(Double(self.data.count) * 1.24), height: geometry.size.height * (1-1/CGFloat(BarChartView.maxPercentage)))
                }
            }
        }
    }
    
    private static func scaleData(data: [[Float]], scale: Float=BarChartView.maxPercentage) -> [[Float]] {
        var res: [[Float]] = [[]]
        for arr in data {
            var row: [Float] = []
            for elt in arr {
                row.append(elt / scale)
            }
            res.append(row)
        }
        return res
    }
    
    private static let maxPercentage: Float = 1.2
    private static let height: CGFloat = 300.0
    private static let barWidth: CGFloat = 30.0
}

struct BarView: View {
    var data: [Float]
    var tag: String
    var colors: [Color]
    
    init(data: [Float], tag: String, colors: [Color], isSorted: Bool=false) {
        self.tag = tag
        self.colors = colors
        self.data = data
        if isSorted {
            self.data.sort()
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack(spacing: 0.0) {
                    if self.data.isEmpty {
                        RoundedRectangle(cornerRadius: BarView.cornerRadius)
                            .foregroundColor(.gray)
                            .opacity(BarView.emptyBarOpacity)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    } else {
                        Spacer(minLength: 0.0)
                        ForEach(0..<self.data.count, id: \.self) { idx in
                            VStack (spacing: 0.0) {
                                Rectangle()
                                    .foregroundColor(self.colors[idx])
                                    .frame(width: geometry.size.width,
                                           height: geometry.size.height * min(1.0, CGFloat(self.data[idx])),
                                           alignment: .bottom)
                            }
                        }
                    }
                }
                Text(self.tag)
                    .fontWeight(.semibold)
                    .shadow(radius: 25.0)
                    .foregroundColor(.white)
            
            }
        }
    }
    
    private static let cornerRadius: CGFloat = 5.0
    private static let emptyBarOpacity: Double = 0.4
    private static let maxPercentage: Float = 1.2
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(data: [[],
                    [0.3,0.1,0.1],
                    [0.5],
                    [0.2, 0.3, 0.3],
                    [1.1],
                    [],
                    []],
                     tags: ["S", "M", "Tu", "W", "Th", "F", "Sa"],
                     colors: [.green, .purple, .orange], showOverflow: true)
    }
}

//struct BarView_Previews: PreviewProvider {
//    static var previews: some View {
//        BarView(data: [0.2, 0.1, 0.5],
//                tag: "Tu",
//                colors: [.green, .purple, .orange, .blue])
//            .frame(width: 25.0, height: 200.0)
//    }
//}
