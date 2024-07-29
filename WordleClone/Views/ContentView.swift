import SwiftUI

struct ContentView: View {
    @StateObject private var statistics = Statistics()
    @StateObject private var game: WordleGame
    
    init() {
        let stats = Statistics()
        _statistics = StateObject(wrappedValue: stats)
        _game = StateObject(wrappedValue: WordleGame(wordList: WordList.words, statistics: stats))
    }

    @State private var showingStatistics = false

    var body: some View {
        VStack {
            Text("Wordle Clone")
                .font(.largeTitle)
                .padding(.top)
            
            GameView(game: game)
            
            if game.isGameOver {
                GameOverView(gameState: game.gameState, targetWord: game.targetWord) {
                    game.resetGame()
                }
            } else {
                KeyboardView(game: game)
            }
            
            Button("Statistics") {
                showingStatistics.toggle()
            }
            .padding()
            .sheet(isPresented: $showingStatistics) {
                StatisticsView(statistics: statistics)
            }
        }
        .alert("Invalid Word", isPresented: $game.showInvalidGuessAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("The word you entered is not in our dictionary. Please try again.")
        }
    }
}
