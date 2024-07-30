import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Theme")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .onChange(of: isDarkMode) { value in
                            applyTheme()
                        }
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .onAppear {
                applyTheme()
            }
        }
    }
    
    private func applyTheme() {
        if isDarkMode {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        } else {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        }
    }
}
