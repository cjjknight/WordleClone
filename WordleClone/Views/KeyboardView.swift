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

    var body: some View {
        VStack {
            ForEach(0..<rows.count) { rowIndex in
                HStack(spacing: 2) {
                    ForEach(rows[rowIndex].map { String($0) }, id: \.self) { key in
                        Button(action: {
                            game.addLetter(Character(key))
                            impactFeedbackGenerator.impactOccurred()
                        }) {
                            Text(key)
                                .font(.system(size: 18))
                                .frame(width: 30, height: 40)
                                .background(backgroundColor(for: key))
                                .foregroundColor(.white)
                        }
                    }
                    if rowIndex == rows.count - 1 {
                        Button(action: {
                            game.removeLetter()
                            impactFeedbackGenerator.impactOccurred()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 18))
                                .frame(width: 30, height: 40)
                                .background(Color.gray)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }

    private func backgroundColor(for key: String) -> Color {
        switch game.keyboardState[Character(key)] {
        case .unused: return .gray
        case .wrongPosition: return .yellow
        case .notInWord: return .black
        case .correct: return .green
        case .none: return .gray
        }
    }
}