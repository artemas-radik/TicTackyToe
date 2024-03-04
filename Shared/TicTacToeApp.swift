import SwiftUI

@main
struct TicTacToeApp: App {
    
    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    
    #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            #if os(macOS)
            // Set a minimum width enough to show all the toolbar icons.
                .frame(minWidth: 500, minHeight: 500)
            #endif
        }
        .commands {
            // For customizing the toolbar on macOS.
            ToolbarCommands()
        }
    }
}
