import Foundation

struct JamModel {
    // 毎時潮位データ    ：    　１～　７２カラム    　３桁×２４時間（０時から２３時）
    let hourlyTideData: [Int]
    //　年月日    ：    ７３～　７８カラム    　２桁×３
    let date: Date
    //　地点記号    ：    ７９～　８０カラム    　２桁英数字記号
    let locationCode: String
    //　満潮時刻・潮位    ：    ８１～１０８カラム    　時刻４桁（時分）、潮位３桁（ｃｍ）
    //　※ 満（干）潮が予測されない場合、満（干）潮時刻を「9999」、潮位を「999」としています。
    let hiTideTime: Date
    let hiTideLevel: Int
    //　干潮時刻・潮位    ：    １０９～１３６カラム    　時刻４桁（時分）、潮位３桁（ｃｍ）
    let lowTideTime: Date
    let lowTideLevel: Int
}
