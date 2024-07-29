import SwiftUI

struct GameView: View {
    @ObservedObject var game: WordleGame

    var body: some View {
        VStack(spacing: 5) {
            ForEach(0..<6) { row in
                HStack(spacing: 5) {
                    ForEach(0..<5) { col in
                        LetterView(letter: game.guesses[row][col], result: getLetterResult(row: row, col: col))
                    }
                }
            }
        }
        .padding()
    }

    private func getLetterResult(row: Int, col: Int) -> LetterResult {
        guard row < game.currentGuess, col < game.guessResults[row].count else {
            return .notGuessed
        }
        return game.guessResults[row][col]
    }
}

struct LetterView: View {
    let letter: Character?
    let result: LetterResult

    var body: some View {
        ZStack {
            Rectangle()
                .fill(backgroundColor)
                .frame(width: 50, height: 50)
            Text(letter.map(String.init) ?? "")
                .font(.title)
                .foregroundColor(.white)
        }
    }

    private var backgroundColor: Color {
        switch result {
        case .correct:
            return .green
        case .wrongPosition:
            return .yellow
        case .notInWord:
            return .gray
        case .notGuessed:
            return .gray.opacity(0.3)
        }
    }
}
