import SwiftUI

struct KeyboardView: View {
    @ObservedObject var game: WordleGame
    let rows = [
        "QWERTYUIOP",
        "ASDFGHJKL",
        "ZXCVBNM"
    ]

    var body: some View {
        VStack {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(row.map { String($0) }, id: \.self) { key in
                        Button(action: {
                            game.addLetter(Character(key))
                        }) {
                            Text(key)
                                .font(.system(size: 18))
                                .frame(width: 30, height: 40)
                                .background(backgroundColor(for: key))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            HStack {
                Button("Delete") {
                    game.removeLetter()
                }
                .padding()
                
                Button("Submit") {
                    game.submitGuess()
                }
                .padding()
                .disabled(game.getCurrentGuess().count != 5 || game.gameState != .playing)
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
