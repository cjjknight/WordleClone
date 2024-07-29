import UIKit

class ViewController: UIViewController {
    private var game: WordleGame!
    private var textFields: [[UITextField]] = []
    private var keyboardButtons: [UIButton] = []
    
    private let gridStackView = UIStackView()
    private let keyboardStackView = UIStackView()
    private let statistics = Statistics() // Initialize Statistics

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
        setupUI()
    }

    private func setupGame() {
        game = WordleGame(wordList: WordList.words, statistics: statistics) // Pass Statistics instance
    }

    private func setupUI() {
        // Implementation as in the previous response
    }

    @objc private func keyboardButtonTapped(_ sender: UIButton) {
        // Implementation as before
    }

    @objc private func submitGuess() {
        // Implementation as before
    }

    private func updateUI(with result: [LetterResult]) {
        // Implementation as before
    }

    private func showAlert(message: String) {
        // Implementation as before
    }
}
