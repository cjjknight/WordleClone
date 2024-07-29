import SwiftUI
import UIKit

struct KeyboardView: View {
    @ObservedObject var game: WordleGame
    let rows = [
        "QWERTYUIOP",
        "ASDFGHJKL",
        "ZXCVBNM"
    ]
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    let lightGrey = Color(UIColor.systemGray5) // Lighter shade of grey

    var body: some View {
        VStack(spacing: 8) { // Adjust spacing
            ForEach(0..<rows.count) { rowIndex in
                HStack(spacing: 4) { // Adjust spacing
                    if rowIndex == rows.count - 1 {
                        Button(action: {
                            game.submitGuess()
                            impactFeedbackGenerator.impactOccurred()
                        }) {
                            Text("Submit")
                                .font(.system(size: 18))
                                .frame(width: 60, height: 45) // Adjust size
                                .background(submitButtonColor)
                                .foregroundColor(submitButtonColor == .blue ? .white : .black)
                        }
                        .disabled(game.getCurrentGuess().count != 5 || game.gameState != .playing)
                    }
                    
                    ForEach(rows[rowIndex].map { String($0) }, id: \.self) { key in
                        Button(action: {
                            game.addLetter(Character(key))
                            impactFeedbackGenerator.impactOccurred()
                        }) {
                            Text(key)
                                .font(.system(size: 18))
                                .frame(width: 30, height: 45) // Adjust size
                                .background(backgroundColor(for: key))
                                .foregroundColor(textColor(for: key))
                        }
                    }
                    
                    if rowIndex == rows.count - 1 {
                        Button(action: {
                            game.removeLetter()
                            impactFeedbackGenerator.impactOccurred()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 18))
                                .frame(width: 45, height: 45) // Adjust size
                                .background(lightGrey)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }

    private var submitButtonColor: Color {
        return game.getCurrentGuess().count == 5 ? .blue : lightGrey
    }

    private func backgroundColor(for key: String) -> Color {
        switch game.keyboardState[Character(key)] {
        case .unused: return lightGrey // Default color
        case .wrongPosition: return .yellow
        case .notInWord: return .black
        case .correct: return .green
        case .none: return lightGrey // Default color
        }
    }

    private func textColor(for key: String) -> Color {
        let bgColor = backgroundColor(for: key)
        if bgColor == .yellow || bgColor == .black || bgColor == .green {
            return .white
        } else {
            return .black
        }
    }
}
