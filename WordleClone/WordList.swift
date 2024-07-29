import Foundation

struct WordList {
    static let words: [String] = {
        guard let url = Bundle.main.url(forResource: "sgb-words", withExtension: "txt"),
              let content = try? String(contentsOf: url) else {
            print("Failed to load word list")
            return []
        }
        
        return content.components(separatedBy: .newlines)
            .map { $0.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { $0.count == 5 }
    }()
}
