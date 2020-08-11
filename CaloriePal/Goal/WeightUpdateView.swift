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
                        self.goalViewModel.updateWeight(weight: weightFloat, date: Date(), rootStore: self.rootStore)
                        self.isPresented = false
                    }
                }
                .padding(.horizontal)
                Form {
                    TextField("lbs", text: self.$weightNumber)
                    .keyboardType(.numberPad)
                }
                Spacer()
            }
            .padding(.top)
        }

    }
}

struct WeightUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        WeightUpdateView(goalViewModel: GoalViewModel(), isPresented: .constant(true))
    }
}
