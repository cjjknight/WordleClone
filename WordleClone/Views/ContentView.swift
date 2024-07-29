import SwiftUI

struct ContentView: View {
    @StateObject private var game = WordleGame(wordList: WordList.words)

    var body: some View {
        VStack {
            if game.isGameOver {
                GameOverView(gameState: game.gameState, targetWord: game.targetWord) {
                    game.resetGame()
                }
            } else {
                GameView(game: game)
                KeyboardView(game: game)
                
                Button("Submit") {
                    if game.getCurrentGuess().count == 5 {
                        game.submitGuess()
                    }
                }
                .padding()
                .disabled(game.getCurrentGuess().count != 5 || game.gameState != .playing)
            }
        }
        .alert("Invalid Word", isPresented: $game.showInvalidGuessAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("The word you entered is not in our dictionary. Please try again.")
        }
    }
}
