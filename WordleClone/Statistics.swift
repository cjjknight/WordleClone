import Foundation

class Statistics: ObservableObject {
    @Published var gamesPlayed: Int
    @Published var gamesWon: Int
    @Published var currentStreak: Int
    @Published var longestStreak: Int

    private let gamesPlayedKey = "gamesPlayed"
    private let gamesWonKey = "gamesWon"
    private let currentStreakKey = "currentStreak"
    private let longestStreakKey = "longestStreak"

    init() {
        self.gamesPlayed = UserDefaults.standard.integer(forKey: gamesPlayedKey)
        self.gamesWon = UserDefaults.standard.integer(forKey: gamesWonKey)
        self.currentStreak = UserDefaults.standard.integer(forKey: currentStreakKey)
        self.longestStreak = UserDefaults.standard.integer(forKey: longestStreakKey)
    }

    func gamePlayed(didWin: Bool) {
        gamesPlayed += 1
        UserDefaults.standard.set(gamesPlayed, forKey: gamesPlayedKey)

        if didWin {
            gamesWon += 1
            currentStreak += 1
            if currentStreak > longestStreak {
                longestStreak = currentStreak
            }
        } else {
            currentStreak = 0
        }

        UserDefaults.standard.set(gamesWon, forKey: gamesWonKey)
        UserDefaults.standard.set(currentStreak, forKey: currentStreakKey)
        UserDefaults.standard.set(longestStreak, forKey: longestStreakKey)
    }
}
