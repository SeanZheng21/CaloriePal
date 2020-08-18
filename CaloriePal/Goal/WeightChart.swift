//
//  WeightChart.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/18/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class WeightChart: ObservableObject {
    init() {
        // Weight Chart
    }
    
    func chartDataPairs(from days: [Day]) -> [(Int, Float)] {
        let sortedDays = days.sorted(by: {(d1, d2) in
            d1.date < d2.date
        })
        var data: [(Int, Float)] = []
        let interval = dataOffset(values: sortedDays.filter({$0.hasWeight()})
            .map({
                $0.weight!
        }))
        for day in sortedDays {
            if day.hasWeight() {
                let difference = day.date.timeIntervalSinceReferenceDate
                    - sortedDays[0].date.timeIntervalSinceReferenceDate + 1
                let differenceDays = Int(difference/(60*60*24))
                data.append((differenceDays, day.weight! - interval.0))
            }
        }
        return data
    }
    
    func chartData(from days: [Day]) -> [Float?] {
        var data: [Float?] = []
        let dataPairs = chartDataPairs(from: days)
        for _ in 0...(dataPairs.last?.0 ?? 1) {
            data.append(nil)
        }
        for pair in dataPairs {
            data[pair.0] = pair.1
        }
        return data
    }
    
    private func dataOffset(values: [Float]) -> (Float, Float) {
        let minValue = values.min()!
        let maxValue = values.max()!
        let margin = (maxValue - minValue) * 0.2
        return (minValue - margin, maxValue + margin)
    }
}
