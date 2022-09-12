//
//  TideRepository.swift
//  tide
//
//  Created by Kosuke Nagao on 2022/09/12.
//

import Foundation


class TideRepository {

    func getTide() -> Tide {

        let tide = Tide(
            date: Date.now,
            place: Place(value: "勝浦"),
            tideLevels: [50, 60, 70, 90, 100, 130, 150,
                         130, 120, 100, 80, 70, 60,
                         50, 60, 70, 90, 100, 130, 150,
                         130, 120, 100, 80, 70, 60
                        ])
        return tide


    }


}
