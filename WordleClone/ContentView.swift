import SwiftUI

struct ContentView: View {
    @StateObject private var game = WordleGame(wordList: WordList.words)
    @State private var showInvalidGuessAlert = false

    var body: some View {
        VStack {
            GameView(game: game)
            KeyboardView(game: game)
            
            Button("Submit") {
                if game.getCurrentGuess().count == 5 {
                    game.submitGuess()
                    if game.gameState == .playing {
                        showInvalidGuessAlert = true
                    }
                }
            }
            .padding()
            .disabled(game.getCurrentGuess().count != 5 || game.gameState != .playing)
        }
        .alert("Invalid Word", isPresented: $showInvalidGuessAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("The word you entered is not in our dictionary. Please try again.")
        }
    }
}
