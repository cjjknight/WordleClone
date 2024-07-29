import Foundation

class WordleGame: ObservableObject {
    @Published private(set) var currentGuess = 0
    @Published private(set) var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)
    @Published private(set) var keyboardState: [Character: LetterState] = [:]
    @Published private(set) var gameState: GameState = .playing
    @Published private(set) var guessResults: [[LetterResult]] = Array(repeating: [], count: 6)

    private let wordList: [String]
    private let maxGuesses = 6
    private var currentTargetWord: String

    var targetWord: String {
        currentTargetWord
    }

    init(wordList: [String]) {
        self.wordList = wordList
        self.currentTargetWord = wordList.randomElement()?.uppercased() ?? "SWIFT"
        resetKeyboardState()
    }

    func addLetter(_ letter: Character) {
        guard gameState == .playing, currentGuess < maxGuesses, guesses[currentGuess].contains(nil) else { return }
        if let index = guesses[currentGuess].firstIndex(of: nil) {
            guesses[currentGuess][index] = letter
        }
    }

    func removeLetter() {
        guard gameState == .playing, currentGuess < maxGuesses else { return }
        if let index = guesses[currentGuess].lastIndex(where: { $0 != nil }) {
            guesses[currentGuess][index] = nil
        }
    }

    func getCurrentGuess() -> String {
            String(guesses[currentGuess].compactMap { $0 })
        }

    
    func submitGuess() {
         let guess = getCurrentGuess()
         guard gameState == .playing, currentGuess < maxGuesses, guess.count == 5 else { return }
         
         guard isValidGuess(guess) else {
             // Handle invalid guess (e.g., show an alert)
             objectWillChange.send()
             return
         }
         
         let result = checkGuess(guess)
         guessResults[currentGuess] = result
         updateKeyboardState(for: guess, with: result)
         currentGuess += 1
         
         if guess.uppercased() == targetWord {
             gameState = .won
         } else if currentGuess == maxGuesses {
             gameState = .lost
         }
         
         objectWillChange.send()
     }

    private func isValidGuess(_ guess: String) -> Bool {
        return wordList.contains(guess.lowercased())
    }

    private func checkGuess(_ guess: String) -> [LetterResult] {
        var result = [LetterResult]()
        let guessUppercased = guess.uppercased()
        
        for (index, letter) in guessUppercased.enumerated() {
            if letter == targetWord[targetWord.index(targetWord.startIndex, offsetBy: index)] {
                result.append(.correct)
            } else if targetWord.contains(letter) {
                result.append(.wrongPosition)
            } else {
                result.append(.notInWord)
            }
        }
        
        return result
    }

    private func updateKeyboardState(for guess: String, with result: [LetterResult]) {
        for (letter, letterResult) in zip(guess, result) {
            let currentState = keyboardState[letter] ?? .unused
            let newState: LetterState
            
            switch letterResult {
            case .correct:
                newState = .correct
            case .wrongPosition:
                newState = currentState == .correct ? .correct : .wrongPosition
            case .notInWord:
                newState = currentState == .correct || currentState == .wrongPosition ? currentState : .notInWord
            case .notGuessed:
                print("Warning: Unexpected 'notGuessed' state in updateKeyboardState")
                newState = currentState
            }
            
            keyboardState[letter] = newState
        }
    }

    private func resetKeyboardState() {
        for letter in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
            keyboardState[letter] = .unused
        }
    }

    var isGameOver: Bool {
        gameState != .playing
    }

    func resetGame() {
        currentGuess = 0
        guesses = Array(repeating: Array(repeating: nil, count: 5), count: 6)
        resetKeyboardState()
        gameState = .playing
        currentTargetWord = wordList.randomElement()?.uppercased() ?? "SWIFT"
    }
}

enum LetterResult {
    case correct, wrongPosition, notInWord, notGuessed
}

enum LetterState {
    case unused, wrongPosition, notInWord, correct
}

enum GameState {
    case playing, won, lost
}
