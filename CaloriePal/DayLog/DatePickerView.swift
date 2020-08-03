//
//  DatePickerView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/3/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct DateBannerView: View {
    @Binding var selectedDate: Date
    @State var showPicker = false
    var body: some View {
        VStack(alignment: .center) {
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .labelsHidden()
        }
    }
    
    // MARK: - Drawing variables
    var viewHeight: CGFloat = 120.0
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DateBannerView(selectedDate: .constant(Date()))
    }
}
