//
//  Tag.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/1/24.
//

import SwiftUI

// Tag Model...
struct Tag: Identifiable, Hashable {
    var id = UUID().uuidString
    var text: String
    var size: CGFloat = 0
}
