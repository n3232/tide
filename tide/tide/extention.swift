//
//  extention.swift
//  tide
//
//  Created by Kosuke Nagao on 2022/09/19.
//

import Foundation

extension String {

    func subString(from: Int, to: Int) -> String {
        //文字列の最初（１文字目）の"位置"を取得する
        let index1: String.Index = self.startIndex
        let index2: String.Index = self.index(index1, offsetBy: from)
        let index3: String.Index = self.index(index1, offsetBy: to)
        let subString = self[index2...index3]
        return String(subString)
    }

}
