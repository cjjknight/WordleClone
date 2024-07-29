import SwiftUI

struct ContentView: View {
    @StateObject private var game = WordleGame(wordList: WordList.words)

    var body: some View {
        VStack {
            Text("Wordle Clone")
                .font(.largeTitle)
                .padding(.top)
            
            if game.isGameOver {
                GameOverView(gameState: game.gameState, targetWord: game.targetWord) {
                    game.resetGame()
                }
            } else {
                GameView(game: game)
                KeyboardView(game: game)
            }
        }
        .alert("Invalid Word", isPresented: $game.showInvalidGuessAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("The word you entered is not in our dictionary. Please try again.")
        }
    }
}
