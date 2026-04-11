//
//  AuthManager.swift
//  Your Market
//

import SwiftUI
import FirebaseAuth
import Combine

@MainActor
class AuthManager: ObservableObject {

    @Published var isAuthenticated = false
    @Published var currentUser: FirebaseAuth.User? = nil
    @Published var isLoading = false

    // Injected so we can start/stop the cart listener on auth change
    var cartService: CartService?

    private var authStateListener: AuthStateDidChangeListenerHandle?

    init() {
        authStateListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.currentUser     = user
                self?.isAuthenticated = user != nil

                if user != nil {
                    self?.cartService?.startListening()
                } else {
                    self?.cartService?.stopListening()
                }
            }
        }
    }

    deinit {
        if let handle = authStateListener {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    // MARK: - Register

    func register(email: String, password: String, fullName: String) async -> String? {
        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let changeRequest = result.user.createProfileChangeRequest()
            changeRequest.displayName = fullName
            try await changeRequest.commitChanges()

            currentUser     = Auth.auth().currentUser
            isAuthenticated = true
            cartService?.startListening()
            return nil
        } catch {
            return friendlyError(error)
        }
    }

    // MARK: - Login

    func login(email: String, password: String) async -> String? {
        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            currentUser     = result.user
            isAuthenticated = true
            cartService?.startListening()
            return nil
        } catch {
            return friendlyError(error)
        }
    }

    // MARK: - Logout

    func logout() {
        do {
            try Auth.auth().signOut()
            cartService?.stopListening()
            currentUser     = nil
            isAuthenticated = false
        } catch {
            print("[AuthManager] Sign out error: \(error)")
        }
    }

    // MARK: - Password Reset

    func sendPasswordReset(email: String) async -> String? {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            return nil
        } catch {
            return friendlyError(error)
        }
    }

    // MARK: - Error helper

    private func friendlyError(_ error: Error) -> String {
        let code = AuthErrorCode(_bridgedNSError: error as NSError)
        switch code?.code {
        case .emailAlreadyInUse:
            return "An account with this email already exists."
        case .wrongPassword, .invalidCredential:
            return "Invalid email or password."
        case .userNotFound:
            return "No account found with this email."
        case .weakPassword:
            return "Password must be at least 6 characters."
        case .invalidEmail:
            return "Please enter a valid email address."
        case .networkError:
            return "Network error. Please check your connection."
        default:
            return "Something went wrong. Please try again."
        }
    }
}
