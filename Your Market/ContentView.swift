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
    case categories
    case cart
    case cleaningProducts
}

struct ContentView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            FrontPageView(path: $path)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .login:
                        LoginView(path: $path)
                    case .register:
                        RegisterView(path: $path)
                    case .categories:
                        CategoriesView()
                    case .cart:
                        CartView()
                    case .cleaningProducts:
                        CleaningProductsView()
                    }
                }
                .dynamicTypeSize(.medium)
        }
    }
}

#Preview {
    ContentView()
}

