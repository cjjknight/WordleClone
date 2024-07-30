import SwiftUI

struct ContentView: View {
    @StateObject private var statistics = Statistics()
    @StateObject private var game: WordleGame
    
    @State private var showingStatistics = false
    @State private var showingSettings = false

    init() {
        let stats = Statistics()
        _statistics = StateObject(wrappedValue: stats)
        _game = StateObject(wrappedValue: WordleGame(wordList: WordList.words, statistics: stats))
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button(action: {
                        showingStatistics.toggle()
                    }) {
                        Image(systemName: "chart.bar") // Use the system icon for simplicity or your custom icon name here
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding()
                    }
                    Spacer()
                    Button(action: {
                        showingSettings.toggle()
                    }) {
                        Image(systemName: "gearshape.fill") // Settings icon
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding()
                    }
                }
                
                Text("Wordle Clone")
                    .font(.largeTitle)
                    .padding(.top)
                
                Spacer()
                
                GameView(game: game)
                    .frame(height: geometry.size.height * 0.5) // Allocate 50% of the height for the game view
                    .padding()
                
                if game.isGameOver {
                    GameOverView(gameState: game.gameState, targetWord: game.targetWord) {
                        game.resetGame()
                    }
                    .frame(height: geometry.size.height * 0.2) // Allocate 20% of the height for the game over view
                    .padding()
                } else {
                    KeyboardView(game: game)
                        .frame(height: geometry.size.height * 0.2) // Allocate 20% of the height for the keyboard view
                        .padding(.bottom)
                }
                
                Spacer()
            }
            .sheet(isPresented: $showingStatistics) {
                StatisticsView(statistics: statistics)
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView() // Ensure you have a SettingsView to present
            }
            .alert("Invalid Word", isPresented: $game.showInvalidGuessAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("The word you entered is not in our dictionary. Please try again.")
            }
        }
    }
}
