//
//  WeightUpdateView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/11/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct WeightUpdateView: View {
    @EnvironmentObject var rootStore: RootStore
    @ObservedObject var goalViewModel: GoalViewModel
    @Binding var isPresented: Bool
    @State var weightNumber: String = ""
    @State var selectedDate: Date = Date()
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Text("Weight")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading)
                    Spacer()
                    Button("Done") {
                        let weightFloat = (self.weightNumber as NSString).floatValue
                        self.goalViewModel.updateWeight(weight: weightFloat, date: self.selectedDate, rootStore: self.rootStore)
                        self.isPresented = false
                    }
                }
                .padding(.horizontal)
                HStack {
                    Spacer()
                    Button(action: {
                        self.selectedDate = self.rootStore.plan.previousDay(withRespectTo: Day(date: self.selectedDate)).date
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.left.circle")
                            .imageScale(.large)
                    })
                    Text("\(self.formatDate(date: self.selectedDate))")
                    Button(action: {
                        self.selectedDate = self.rootStore.plan.followingDay(withRespectTo: Day(date: self.selectedDate)).date
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.right.circle")
                            .imageScale(.large)
                    })
                    Spacer()
                }
                .padding()
                Form {
                    TextField("lbs", text: self.$weightNumber)
                    .keyboardType(.numberPad)
                }
                Spacer()
            }
            .padding(.top)
        }
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        return formatter.string(from: date)
    }
}

struct WeightUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        WeightUpdateView(goalViewModel: GoalViewModel(), isPresented: .constant(true))
    }
}
