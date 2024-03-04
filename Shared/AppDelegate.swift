//
//  AppDelegate.swift
//  TicTackyToe
//
//  Created by Artemas on 3/4/24.
//

import Foundation
import SwiftUI
import Mixpanel

#if os(iOS)
import UIKit
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Mixpanel.initialize(token: "667b2112833cc73b56ff697906f5c09e", trackAutomaticEvents: true)
        return true
    }
}
#elseif os(macOS)
import AppKit
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        Mixpanel.initialize(token: "667b2112833cc73b56ff697906f5c09e")
    }
}
#endif
