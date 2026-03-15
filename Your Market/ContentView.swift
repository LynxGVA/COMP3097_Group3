//
//  ContentView.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//

import SwiftUI

enum Route: Hashable {
    case login
    case register
}

struct ContentView: View {

    @StateObject private var authManager = AuthManager()
    @State private var path = NavigationPath()
    
    var body: some View {
        Group {
            if authManager.isAuthenticated {
                // The Main App Flow
                NavigationStack {
                    CategoriesView()
                }
            } else {
                // The Authentication Flow
                NavigationStack(path: $path) {
                    FrontPageView(path: $path)
                        .navigationDestination(for: Route.self) { route in
                            switch route {
                            case .login:
                                LoginView(path: $path)
                            case .register:
                                RegisterView(path: $path)
                            }
                        }
                }
            }
        }
        .environmentObject(authManager)
    }
}
