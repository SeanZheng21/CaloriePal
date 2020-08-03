//
//  DateBannerView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/3/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct DateBannerView: View {
    @Binding var selectedDate: Date
    @EnvironmentObject var dayLog: DayLog
    @State var showPicker = false
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Button(action: {
                    self.dayLog.setPreviousDay()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.left.circle")
                        .imageScale(.large)
                })
                Spacer()
                Image(systemName: "calendar.circle")
                    .imageScale(.large)
//                    .foregroundColor(.blue)
                Text("\(dayLog.dateString)")
                Button(action: {
                    withAnimation {
                        self.showPicker.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(self.showPicker ? 90 : 0))
                        .scaleEffect(self.showPicker ? 1.5 : 1)
                        .padding()
                }
                Spacer()
                Button(action: {
                    self.dayLog.setFollowingDay()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.right.circle")
                        .imageScale(.large)
                })
            }
            if showPicker {
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .onReceive([self.selectedDate].publisher.first(), perform: {value in
                        if !value.onSameDay(otherDate: self.dayLog.day.date) {
                            let updated = self.dayLog.setToDate(date: value)
                            if !updated {
                                self.selectedDate = self.dayLog.day.date
                            }
                        }
                    })
                    .labelsHidden()
            }
        }
        .padding(.horizontal)
        .background(Color.gray.opacity(DayCalorieView.backgroundOpacity))
    }
    
    // MARK: - Drawing variables
    var viewHeight: CGFloat = 120.0
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DateBannerView(selectedDate: .constant(Date()))
    }
}
