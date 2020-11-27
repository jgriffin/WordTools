import Foundation

public enum WordList: String {
    case wordlist = "wordlist.txt"
    case unix_words = "unix_words.txt"
    case unix_propernames = "unix_propernames.txt"
    case anEnglishWordList = "AnEnglishWordList.txt"
    case top12ThousantProbable = "Top12Thousand-probable-v2.txt"

    var url: URL? {
        Bundle.module.url(forResource: rawValue, withExtension: nil)
    }
}

extension WordList {
    public func readWords() -> [Substring] {
        guard let url = url,
            let contents = try? String(contentsOf: url, encoding: .utf8)
        else {
            return []
        }

        return contents
            .split(separator: "\n")
    }
}
