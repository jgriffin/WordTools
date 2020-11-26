import Foundation

public struct WordList {
    private static let wordlistURL = Bundle.module.url(forResource: "wordlist", withExtension: "txt")

    public static let standard: [Substring] = {
        guard let url = wordlistURL,
              let contents = try? String(contentsOf: url, encoding: .utf8)
        else {
            return []
        }

        return contents
            .split(separator: "\n")
    }()
    
    
    public static let standardLettersSorted: [String] = standard.map { $0.sortLetters() }
}
