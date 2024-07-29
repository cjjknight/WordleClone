import SwiftUI

struct StatisticsView: View {
    @ObservedObject var statistics: Statistics

    var body: some View {
        VStack {
            Text("Statistics")
                .font(.largeTitle)
                .padding()

            HStack {
                VStack {
                    Text("Games Played")
                    Text("\(statistics.gamesPlayed)")
                }
                .padding()

                VStack {
                    Text("Games Won")
                    Text("\(statistics.gamesWon)")
                }
                .padding()
            }

            HStack {
                VStack {
                    Text("Current Streak")
                    Text("\(statistics.currentStreak)")
                }
                .padding()

                VStack {
                    Text("Longest Streak")
                    Text("\(statistics.longestStreak)")
                }
                .padding()
            }
        }
    }
}
