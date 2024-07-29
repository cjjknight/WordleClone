import SwiftUI

struct LetterView: View {
    let letter: Character?
    let result: LetterResult

    var body: some View {
        ZStack {
            Rectangle()
                .fill(backgroundColor)
                .overlay(
                    Rectangle()
                        .stroke(borderColor, lineWidth: 2)
                )
            Text(letter.map(String.init) ?? "")
                .font(.title)
                .foregroundColor(.black)
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
}
