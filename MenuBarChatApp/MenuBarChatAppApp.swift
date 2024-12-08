import SwiftUI

@main
struct MenuBarChatAppApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView() // Hides unnecessary settings window
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var popover = NSPopover()

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create a menu bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "cloud.fill", accessibilityDescription: "Chat with Azure AI")
            button.action = #selector(togglePopover)
        }

        // Configure the popover to display ContentView
        popover.contentViewController = NSHostingController(rootView: ContentView())
        popover.behavior = .transient
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
}
