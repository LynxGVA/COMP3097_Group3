//
//  ContentView.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            FrontPageView()
                .dynamicTypeSize(.medium)
            //LoginView()
            //RegisterView()
            //CategoriesView()
        }
    }
}

#Preview {
    ContentView()
}
