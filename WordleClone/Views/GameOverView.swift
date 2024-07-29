import SwiftUI

struct GameOverView: View {
    let gameState: GameState
    let targetWord: String
    let onRestart: () -> Void

    var body: some View {
        VStack {
            if gameState == .won {
                Text("Congratulations! You won!")
                    .font(.largeTitle)
                    .padding()
            } else {
                Text("Game Over! The word was \(targetWord)")
                    .font(.largeTitle)
                    .padding()
            }
            Button("Play Again", action: onRestart)
                .padding()
        }
    }
}
