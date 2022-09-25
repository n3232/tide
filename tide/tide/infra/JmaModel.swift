import Foundation

struct JmaModel {
    // 毎時潮位データ    ：    　１～　７２カラム    　３桁×２４時間（０時から２３時）
    let hourlyTideData: [Int]
    //　年月日    ：    ７３～　７８カラム    　２桁×３
    let date: Date
    //　地点記号    ：    ７９～　８０カラム    　２桁英数字記号
    let locationCode: String
    let hiTide1DateTime: Date
    let hiTide1Level: Int//84-87
    let hiTide2DateTime: Date
    let hiTide2Level: Int


    let lowTide1DateTime: Date
    let lowTide1Level: Int
    let lowTide2DateTime: Date
    let lowTide2Level: Int

    static func from(_ line: String) -> Self {
        let hourlyTideData = getHourlyTideData(line)
        let date = getDate(line)
        let locationCode = getLocationCode(line)
        //　満潮時刻・潮位    ：    ８１～１０８カラム    　時刻４桁（時分）、潮位３桁（ｃｍ）
        //　※ 満（干）潮が予測されない場合、満（干）潮時刻を「9999」、潮位を「999」としています。
        let hiTide1DateTime = getTideDateTime(line, from: 80, to: 83)
        let hiTide1Level = getTideLevel(line, from: 84, to: 86)
        let hiTide2DateTime = getTideDateTime(line, from: 87, to: 90)
        let hiTide2Level = getTideLevel(line, from: 91, to: 93)
        //　干潮時刻・潮位    ：    １０９～１３６カラム    　時刻４桁（時分）、潮位３桁（ｃｍ）
        let lowTide1DateTime = getTideDateTime(line, from: 108, to: 111)
        let lowTide1Level = getTideLevel(line, from: 112, to: 114)
        let lowTide2DateTime = getTideDateTime(line, from: 115, to: 118)
        let lowTide2Level = getTideLevel(line, from: 119, to: 121)

        return JmaModel(
            hourlyTideData: hourlyTideData,
            date: date,
            locationCode: locationCode,
            hiTide1DateTime: hiTide1DateTime,
            hiTide1Level: hiTide1Level,
            hiTide2DateTime: hiTide2DateTime,
            hiTide2Level: hiTide2Level,
            lowTide1DateTime: lowTide1DateTime,
            lowTide1Level: lowTide1Level,
            lowTide2DateTime: lowTide2DateTime,
            lowTide2Level: lowTide2Level
        )
        
    }

    static func getHourlyTideData(_ line: String) -> [Int] {
        // 毎時潮位データ    ：    　１～　７２カラム    　３桁×２４時間（０時から２３時）
        let substring = line.subString(from: 0, to: 71)
        var stringArray = [String]()
        var value = ""
        substring.forEach { char in
            value += String(char)
            if value.count == 3 {
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

    static func getLocationCode(_ line: String) -> String {
        //　地点記号    ：    ７９～　８０カラム    　２桁英数字記号
        return line.subString(from: 78, to: 79)
    }

    static func getTideDateTime(_ line: String, from: Int, to: Int) -> Date {

        let HHmm1 = line.subString(from: from, to: to).replacingOccurrences(of: " ", with: "0")

        //　年月日    ：    ７３～　７８カラム    　２桁×３
        let substring = line.subString(from: 72, to: 77)
        let yyMMdd = substring.replacingOccurrences(of: " ", with: "0")

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyMMddHHmm"

        let date = formatter.date(from: yyMMdd + HHmm1)!
        return date
    }

    static func getTideLevel(_ line: String, from: Int, to: Int) -> Int {
        let string = line.subString(from: from, to: to).trimmingCharacters(in: .whitespaces)
        return Int(string)!
    }

}
