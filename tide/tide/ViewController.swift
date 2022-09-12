//
//  ViewController.swift
//  tide
//
//  Created by Kosuke Nagao on 2022/09/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tideRepository = TideRepository()
        let tide = tideRepository.getTide()
        printTide(tide)
    }

    private func printTide(_ tide: Tide) {

        print(tide.date)
        print(tide.place)

        tide.tideLevels.forEach{
            print($0)
        }

    }


}

