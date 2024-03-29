import SwiftUI
import StoreKit
import Mixpanel

/// A button for rating the app on the app store.
struct RateButton : View {
    @Environment(\.openURL) var openURL
    
    var body: some View {
        Button {
            guard let writeReviewURL = URL(string: "https://apps.apple.com/app/id1507852505?action=write-review") else {
                fatalError("Expected a valid URL")
            }
            openURL(writeReviewURL)
        } label: {
            Label("Rate", systemImage: "star")
        }
    }
}

/// A button for resetting the grid.
struct RestartButton : View {
    var resetPublisher: EventPublisher
    
    var body: some View {
        Button {
            Mixpanel.mainInstance().track(event: "Game Reset")
            resetPublisher.send()
        } label: {
            Label("Restart", systemImage: "arrow.counterclockwise")
        }
    }
}

/// A button for switching the game mode.
struct SwitchGameModeButton : View {
    @AppStorage("isPVE") private var isPVE = true
    
    var resetPublisher: EventPublisher
    
    var body: some View {
        Button {
            isPVE.toggle()
            resetPublisher.send()
        } label: {
            Label(isPVE ? "1 Player" : "2 Players",
                  systemImage: isPVE ? "person" : "person.2")
        }
    }
}

/// A menu for changing the AI difficulty level.
struct DifficultyMenu : View {
    @AppStorage("difficulty") private var difficulty = TicTacToe.Difficulty.medium
    
    var body: some View {
        Menu {
            Picker("Difficulty", selection: $difficulty) {
                ForEach(TicTacToe.Difficulty.allCases) { difficulty in
                    Text(difficulty.rawValue.capitalized)
                        .tag(difficulty)
                }
            }
            .pickerStyle(.inline)
        } label: {
            Label("Difficulty", systemImage: "speedometer")
        }
    }
}

/// A menu for changing the app's appearance.
struct AppearanceMenu : View {
    @AppStorage("appearance") private var appearance = Appearance.system
    
    var body: some View {
        Menu {
            Picker("Appearance", selection: $appearance) {
                ForEach(Appearance.allCases) { appearance in
                    Text(appearance.rawValue.capitalized)
                        .id(appearance)
                }
            }
            .pickerStyle(.inline)
        } label: {
            Label("Appearance", systemImage: "sun.max")
        }
    }
}
