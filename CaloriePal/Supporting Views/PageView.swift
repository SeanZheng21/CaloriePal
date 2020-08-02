//
//  PageView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/30/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0

    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
//                .padding(.trailing)
//                .background(Color.black)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView([Int](0...8).map { ServingSizeCard(servingSizeImageIndex: $0) })
            .aspectRatio(1, contentMode: .fit)
    }
}
