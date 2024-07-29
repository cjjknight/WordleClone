import SwiftUI

struct LetterView: View {
    let letter: Character?
    let result: LetterResult
    @State private var flipped = false

    var body: some View {
        ZStack {
            Rectangle()
                .fill(flipped ? backgroundColor : .white)
                .overlay(
                    Rectangle()
                        .stroke(borderColor, lineWidth: 2)
                )
                .rotation3DEffect(
                    .degrees(flipped ? 0 : 180),
                    axis: (x: 0, y: 1, z: 0)
                )
                .animation(.easeInOut(duration: 0.6), value: flipped)
            Text(letter.map(String.init) ?? "")
                .font(.title)
                .foregroundColor(textColor)
                .opacity(flipped ? 1 : 1) // Ensure the letter is always visible
                .rotation3DEffect(
                    .degrees(flipped ? 0 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
        }
        .onChange(of: result) { _ in
            withAnimation {
                flipped.toggle()
            }
        }
    }

    private var backgroundColor: Color {
        switch result {
        case .correct:
            return .green
        case .wrongPosition:
            return .yellow
        case .notInWord:
            return .gray
        case .notGuessed:
            return .white
        }
    }

    private var borderColor: Color {
        switch result {
        case .notGuessed:
            return .black
        default:
            return .clear
        }
    }

    private var textColor: Color {
        switch result {
        case .correct, .wrongPosition, .notInWord:
            return .white
        case .notGuessed:
            return .black
        }
    }
}
