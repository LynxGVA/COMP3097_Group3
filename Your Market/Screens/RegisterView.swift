//
//  LoginView.swift
//  Your Market
//
//  Created by Lhekdup Tenzin on 2026-02-06.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    
                    Text("Create Account")
                        .font(AppFont.playwriteRegular(30))
                    
                    Text("Register to start shopping")
                        .font(AppFont.playwriteRegular(16))
                        .opacity(0.8)
                    
                    VStack(spacing: 14) {
                        
                        // Full Name
                        ZStack {
                            Image("fullname_input")
                                .resizable(
                                    capInsets: EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20),
                                    resizingMode: .stretch
                                )
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .offset(x: -45)
                            
                            
                            
                            TextField("Full Name", text: $fullName)
                                .font(AppFont.playwriteRegular(18))
                                .padding(.horizontal, 18)
                                .textInputAutocapitalization(.words)
                                .autocorrectionDisabled(true)
                        }
                        
                        // Email
                        ZStack {
                            Image("email_input")
                                .resizable(
                                    capInsets: EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20),
                                    resizingMode: .stretch
                                )
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .offset(x: -45)
                            
                            TextField("Email", text: $email)
                                .font(AppFont.playwriteRegular(18))
                                .padding(.horizontal, 18)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                                .autocorrectionDisabled(true)
                        }
                        
                        // Password
                        ZStack {
                            Image("password_input") // <-- your PNG (or a password-specific one)
                                .resizable(
                                    capInsets: EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20),
                                    resizingMode: .stretch
                                )
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .offset(x: -45)
                            
                            SecureField("Password", text: $password)
                                .font(AppFont.playwriteRegular(18))
                                .padding(.horizontal, 18)
                                .textInputAutocapitalization(.never)
                                .textContentType(.newPassword)
                        }
                        
                        // Confirm Password
                        ZStack {
                            Image("password_input") // <-- your PNG
                                .resizable(
                                    capInsets: EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20),
                                    resizingMode: .stretch
                                )
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .offset(x: -45)
                            
                            SecureField("Confirm Password", text: $confirmPassword)
                                .font(AppFont.playwriteRegular(18))
                                .padding(.horizontal, 18)
                                .textInputAutocapitalization(.never)
                                .textContentType(.newPassword)
                        }
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.85))
                    )
                    
                    // Register button
                    Button {
                    } label: {
                        Text("Register")
                            .font(AppFont.playwriteRegular(20))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.black.opacity(0.85))
                            )
                            .foregroundColor(.white)
                    }
                    .padding(.top, 6)
                    
                    // Bottom link
                    HStack(spacing: 6) {
                        Text("Already have an account?")
                            .font(AppFont.playwriteRegular(14))
                            .opacity(0.8)
                        
                        NavigationLink {
                            LoginView()
                        } label: {
                            Text("Login")
                                .font(AppFont.playwriteRegular(14))
                                .underline()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 6)
                }
                .padding(.horizontal, 20)
                .padding(.top, 80)
                .padding(.bottom, 40)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image("back_button")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 84, height: 84)
                }
            }
        }
    }
}
        

#Preview {
    NavigationStack {
        RegisterView()
    }
}
