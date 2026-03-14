//
//  AuthManager.swift
//  Your Market
//
//  Created by Lhekdup Tenzin on 2026-03-14.
//

import SwiftUI
import Combine

class AuthManager: ObservableObject {
    // Keeps track of whether the user is logged in
    @Published var isAuthenticated = false
    
   
    // I added a default user so we can test logging in right away!
    @AppStorage("registeredUsers") private var usersData: Data = Data()
    private var registeredUsers: [String: String] {
        get {
            if let decoded = try? JSONDecoder().decode([String: String].self, from: usersData) {
                return decoded
            }
            return ["test@test.com": "password123"] // Dummy default credential
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                usersData = encoded
            }
        }
    }
    

    func login(email: String, pass: String) -> Bool {
        let cleanEmail = email.lowercased().trimmingCharacters(in: .whitespaces)
        // Check if the email exists and the password matches
        if registeredUsers[cleanEmail] == pass {
            isAuthenticated = true
            return true
        }
        return false // Login failed
    }
    
    func register(email: String, pass: String) -> Bool {
        let cleanEmail = email.lowercased().trimmingCharacters(in: .whitespaces)
        // Check if user already exists
        if registeredUsers.keys.contains(cleanEmail) {
            return false // Account already exists
        }
        // Save new user and log them in
        registeredUsers[cleanEmail] = pass
        isAuthenticated = true
        return true
    }
    
    func logout() {
        isAuthenticated = false
    }
}
