//
//  Your_MarketApp.swift
//  Your Market
//

import SwiftUI
import FirebaseCore

@main
struct Your_MarketApp: App {

    @StateObject private var authManager = AuthManager()
    @StateObject private var cartService = CartService()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
                .environmentObject(cartService)
                .onAppear {
                    // Give AuthManager a reference to CartService
                    // so it can start/stop the Firestore listener on login/logout
                    authManager.cartService = cartService
                }
        }
    }
}
