import SwiftUI

struct SettingsView: View {
    @State private var isDarkMode = false
    @State private var isSoundEnabled = true
    @State private var volume: Double = 0.5
    @State private var showHints = true
    @State private var notificationEnabled = true
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Theme")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                    Toggle("Colorblind Mode", isOn: $isDarkMode)
                }
                
                Section(header: Text("Sound")) {
                    Toggle("Sound Effects", isOn: $isSoundEnabled)
                    if isSoundEnabled {
                        Slider(value: $volume, in: 0...1) {
                            Text("Volume")
                        }
                    }
                }
                
                Section(header: Text("Game")) {
                    Toggle("Show Hints", isOn: $showHints)
                    Button(action: {
                        // Add action to reset game data
                    }) {
                        Text("Reset Game Data")
                            .foregroundColor(.red)
                    }
                }
                
                Section(header: Text("Notifications")) {
                    Toggle("Daily Puzzle Notifications", isOn: $notificationEnabled)
                    if notificationEnabled {
                        // Add notification time settings here
                    }
                }
                
                Section(header: Text("Help & Support")) {
                    NavigationLink("How to Play", destination: Text("Instructions..."))
                    NavigationLink("Contact Support", destination: Text("Support Info..."))
                }
                
                Section(header: Text("About")) {
                    NavigationLink("About the App", destination: Text("App Info..."))
                    NavigationLink("Terms of Service", destination: Text("Terms of Service..."))
                    NavigationLink("Privacy Policy", destination: Text("Privacy Policy..."))
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}
