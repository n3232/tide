//
//  Tide.swift
//  tide
//
//  Created by Kosuke Nagao on 2022/09/12.
//

import Foundation

struct Tide {

    let date: Date
    let place: Place
    let tideLevels: [Int]
    let typeType: TydeType


}

enum TydeType: String {
    case ohshio = "大潮"
    case nakashio = "中潮"
    case koshio = "小潮"
    case nagashio = "長潮"
    case wakashio = "若潮"
}
