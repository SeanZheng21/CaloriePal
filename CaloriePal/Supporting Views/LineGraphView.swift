//
//  LineGraph.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/18/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct LineGraphView: View {
    @State var on = true
    var data: [Float?]
    
    var body: some View {
//        VStack {
            LineGraph(dataPoints: data.map{
                if let point = $0 {
                    return CGFloat(point)
                } else {
                    return nil
                }
            })
                .trim(to: on ? 1 : 0)
                .stroke(Color.red, lineWidth: 2)
                .aspectRatio(16/9, contentMode: .fit)
                .border(Color.gray, width: 1)
                .padding()
//            Button("Animate") {
//                withAnimation(.easeInOut(duration: 2)) {
//                    self.on.toggle()
//                }
//            }
//        }
    }
}

struct LineGraph: Shape {
    var dataPoints: [CGFloat?]
    
    init(dataPoints: [CGFloat?]) {
        self.dataPoints = []
        var scale: CGFloat = 0
        for p in dataPoints {
            if let pt = p {
                scale = max(scale, pt)
            }
        }
        for point in dataPoints {
            if let p = point {
                self.dataPoints.append(p / scale)
            } else {
                self.dataPoints.append(nil)
            }
        }
    }

    func path(in rect: CGRect) -> Path {
        func point(at ix: Int) -> CGPoint? {
            if let point = dataPoints[ix] {
                let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
                let y = (1-point) * rect.height
                return CGPoint(x: x, y: y)
            } else {
                return nil
            }
        }

        return Path { p in
            guard dataPoints.count > 1 else { return }
            let start = dataPoints[0]
            p.move(to: CGPoint(x: 0, y: (1-start!) * rect.height))
            for idx in dataPoints.indices {
                if let pointToAdd = point(at: idx) {
                    p.addLine(to: pointToAdd)
                }
            }
        }
    }
}

struct LineGraph_Previews: PreviewProvider {
    static var previews: some View {
        LineGraphView(data: [0.1, nil, 0.3, 0.2, 0.5])
            .frame(width: 300, height: 300, alignment: .center)
    }
}
