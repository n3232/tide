import Foundation

struct Jma {

    func getTideTxt() {

        let url = URL(string: "https://www.data.jma.go.jp/kaiyou/data/db/tide/suisan/txt/2023/ZF.txt")!
        let task = URLSession.shared.dataTask(
            with: url,
            completionHandler: { data, response, error in
                if let error = error {
                    print("error:", error)
                    // TODO error handling
//                    DispatchQueue.main.async {
//                    }
                } else if let data = data {
                    print(data)
                    if let dataString = String(data: data, encoding: .utf8) {
                        parser(dataString)
                    }
                }
            }
        )
        task.resume()
    }

    func parser(_ data: String) {

//        let lines = data.components(separatedBy: "\n")
        let lines = data.split(separator: "\n")

        

        print(lines)
        print("count=",lines.count)


    }

}
//https://www.data.jma.go.jp/kaiyou/db/tide/suisan/readme.html
//毎時潮位データ    ：    　１～　７２カラム    　３桁×２４時間（０時から２３時）
//　年月日    ：    ７３～　７８カラム    　２桁×３
//　地点記号    ：    ７９～　８０カラム    　２桁英数字記号
//　満潮時刻・潮位    ：    ８１～１０８カラム    　時刻４桁（時分）、潮位３桁（ｃｍ）
//　干潮時刻・潮位    ：    １０９～１３６カラム    　時刻４桁（時分）、潮位３桁（ｃｍ）
//　※ 満（干）潮が予測されない場合、満（干）潮時刻を「9999」、潮位を「999」としています。
// 地点記号
// https://www.data.jma.go.jp/kaiyou/db/tide/suisan/station2023.php
// 66103138165179179166147126113112123143164181186177153117 75 35  5 -8  022 1 1QL 429181145518699999999999999 93611122 7 -899999999999999
