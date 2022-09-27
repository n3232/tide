import Foundation
//https://www.data.jma.go.jp/kaiyou/db/tide/suisan/station2023.php
enum Location: String {
    case ZF


    var description: Dictionary<String,String> {
            switch self {
            case .ZF:
                return ["ZF":"勝浦"]
            }
        }
}


