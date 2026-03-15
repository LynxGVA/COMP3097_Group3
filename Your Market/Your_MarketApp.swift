//
//  Your_MarketApp.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//
import SwiftUI
import FirebaseCore

@main
struct Your_MarketApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}



