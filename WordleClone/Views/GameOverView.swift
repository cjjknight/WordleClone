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
                    .minimumScaleFactor(0.5) // Allow text to shrink
                    .lineLimit(1) // Ensure text doesn't wrap
            } else {
                Text("Game Over! The word was \(targetWord)")
                    .font(.largeTitle)
                    .minimumScaleFactor(0.5) // Allow text to shrink
                    .lineLimit(1) // Ensure text doesn't wrap
            }
            Button("Play Again", action: onRestart)
                .padding()
        }
    }
}
