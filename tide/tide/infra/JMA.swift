import Foundation

struct Jma {

    func getJmaModel(date: Date, locationCode: String) -> JmaModel? {

        let url = getUrl(date, locationCode)
        Task { () -> JmaModel? in
            var txt = ""
            do {
                txt = try await downloadTxt(url: url)
                print("result", txt)

            } catch {
                print("error", error)
            }
            print("after download")
            return changeJmaModel(txt, date)
        }
//        print("after task")
//        var result:JmaModel? = nil
//        result = changeJmaModel(txt, date)
        return nil
    }

    func downloadTxt(url: URL) async throws -> String {
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = String(data: data, encoding: .utf8)!
        print(result)
        return result
    }


//https://ja.stackoverflow.com/questions/52727/swift4でのurlsessiontaskを用いたapiからのデータ取得について
//    func fetch(completion: @escaping (String)->Void) {
//        let url: URL = URL(string:"http://127.0.0.1:5000/study")!
//
//        let task: URLSessionTask = URLSession.shared.dataTask(
//            with: url,
//            completionHandler: { data, response, error in
//                do {
//                    if let data = data {
//                        let dataString = String(data: data, encoding: .utf8)
//                        //`URLSession.dataTask(with:completionHandler:)`の完了ハンドラの中で、自前の完了ハンドラを呼ぶ
//                        completion(dataString)
//                    }
//                } catch {
//                    print("error:", error.localizedDescription)
//                    completion("") //<- 同上(エラー時のことも考えておきましょう)
//                }
//            })
//                task.resume()//実行する
//                //↑「`task.resume()`を呼んだら後は何もしてはいけない」と思っておいた方が良い
//    }

    func getUrl(_ date: Date, _ locationCode: String) -> URL {
        let year = getYearFrom(date)
        return URL(string:"https://www.data.jma.go.jp/kaiyou/data/db/tide/suisan/txt/\(year)/\(locationCode).txt")!
//        "https://www.data.jma.go.jp/kaiyou/data/db/tide/suisan/txt/2023/ZF.txt"
    }

    func getYearFrom(_ date: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: date) // 2021
        return year
    }

    func changeJmaModel(_ txt: String, _ date: Date) -> JmaModel {
        let dayOfYear = getDayOfYear(from: date)
        let line = String(txt.split(separator: "\n")[dayOfYear])
        return JmaModel.from(line)
    }

    func getDayOfYear(from date: Date) -> Int {
        let cal = Calendar.current
        let day = cal.ordinality(of: .day, in: .year, for: date)
        return day!
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
