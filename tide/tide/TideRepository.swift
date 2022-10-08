//
//  TideRepository.swift
//  tide
//
//  Created by Kosuke Nagao on 2022/09/12.
//

import Foundation


class TideRepository {

    func getTide(date: Date, place: Place) -> Tide {

        let model = Jma().getJmaModel(date: date, locationCode: "ZF")
        
        let tide = Tide.fromJmaModel(model!)
//        let tide = Tide(
//            date: date,
//            place: place,
//            tideLevels: [50, 60, 70, 90, 100, 130, 150,
//                         130, 120, 100, 80, 70, 60,
//                         50, 60, 70, 90, 100, 130, 150,
//                         130, 120, 100, 80, 70, 60
//                        ],
//            typeType: .koshio)
        return tide

    }


}
