import SwiftUI

struct GameView: View {
    @ObservedObject var game: WordleGame

    var body: some View {
        VStack(spacing: 10) { // Adjust spacing
            ForEach(0..<6) { row in
                HStack(spacing: 10) { // Adjust spacing
                    ForEach(0..<5) { col in
                        LetterView(letter: game.guesses[row][col], result: getLetterResult(row: row, col: col))
                            .frame(width: 60, height: 60) // Adjust size
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
