import Foundation

struct JmaModel {
    // 毎時潮位データ    ：    　１～　７２カラム    　３桁×２４時間（０時から２３時）
    let hourlyTideData: [Int]
    //　年月日    ：    ７３～　７８カラム    　２桁×３
    let date: Date
    //　地点記号    ：    ７９～　８０カラム    　２桁英数字記号
    let locationCode: Location
    //　満潮時刻・潮位    ：    ８１～１０８カラム    　時刻４桁（時分）、潮位３桁（ｃｍ）
    //　※ 満（干）潮が予測されない場合、満（干）潮時刻を「9999」、潮位を「999」としています。
    let hiTideTime: Date
    let hiTideLevel: Int
    //　干潮時刻・潮位    ：    １０９～１３６カラム    　時刻４桁（時分）、潮位３桁（ｃｍ）
    let lowTideTime: Date
    let lowTideLevel: Int

    static func from(line: String) -> Self {
        let hourlyTideData = getHourlyTideData(line)
        let date = getDate(line)
        //　地点記号    ：    ７９～　８０カラム    　２桁英数字記号
        let locationCode = Location.ZF
        //　満潮時刻・潮位    ：    ８１～１０８カラム    　時刻４桁（時分）、潮位３桁（ｃｍ）
        //　※ 満（干）潮が予測されない場合、満（干）潮時刻を「9999」、潮位を「999」としています。
        let hiTideTime = Date.now
        let hiTideLevel = 0
        //　干潮時刻・潮位    ：    １０９～１３６カラム    　時刻４桁（時分）、潮位３桁（ｃｍ）
        let lowTideTime = Date.now
        let lowTideLevel = 0


        return JmaModel(
            hourlyTideData: hourlyTideData,
            date: date,
            locationCode: locationCode,
            hiTideTime: hiTideTime,
            hiTideLevel: hiTideLevel,
            lowTideTime: lowTideTime,
            lowTideLevel: lowTideLevel
        )
        
    }

// "012345678" -> ["012", "345", "678"]

    static func getHourlyTideData(_ line: String) -> [Int] {
        // 毎時潮位データ    ：    　１～　７２カラム    　３桁×２４時間（０時から２３時）
        let substring = line.subString(from: 0, to: 71)
        var stringArray = [String]()
        var value = ""
        substring.forEach { char in
            value += String(char)
            if (value.count == 3) {
                stringArray.append(value.trimmingCharacters(in: .whitespaces))
                value = ""
            }
        }

        let results = stringArray.compactMap {
            Int($0)
        }
        return results
    }

    static func getDate(_ line: String) -> Date {
        //　年月日    ：    ７３～　７８カラム    　２桁×３
        let substring = line.subString(from: 72, to: 77)
        let dateString = substring.replacingOccurrences(of: " ", with: "0")

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyMMdd"
        let date = formatter.date(from: dateString)!
        return date
    }
}
