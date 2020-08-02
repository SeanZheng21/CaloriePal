//
//  MultiProgressBarView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/2/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct MultiProgressBarView: View {
    @ObservedObject var multiProgressBar: MultiProgressBar
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.2)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                HStack(spacing: 0.0) {
                    ForEach(0..<self.multiProgressBar.valuesCount()) { index in
                        Rectangle().frame(
                            width: min(CGFloat(self.multiProgressBar.itemValue(at: index)!)*geometry.size.width/1.2, geometry.size.width),
                                          height: geometry.size.height)
                            .foregroundColor(self.multiProgressBar.itemColor(at: index))
                        .animation(.linear)
                    }
                }
                
                Rectangle().frame(width: 3, height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemRed))
                    .offset(x: geometry.size.width/1.2, y: 0)
            }.cornerRadius(45.0)
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        MultiProgressBarView(multiProgressBar:
            MultiProgressBar(total: 50, values: [20,20], colors: [.purple, .green]))
            .frame(height: 15)
    }
}
