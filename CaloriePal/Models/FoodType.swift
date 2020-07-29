//
//  FoodType.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/28/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

enum FoodType: String, CaseIterable, Codable, Hashable {
    case each = "each"
    case drink = "drink"
    case weight = "weight"
}
