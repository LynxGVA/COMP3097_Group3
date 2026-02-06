//
//  FrontPageVoew.swift
//  Your Market
//
//  Created by Lhekdup Tenzin on 2026-02-06.
//

import SwiftUI

struct FrontPageView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("frontpage_background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    Spacer().frame(height: 60)

                    // 2) Logo / Title image
                    Image("yourmarket_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220)
                        .padding(.top, 10)

                    Spacer()

                    // 3) Login button (PNG)
                    NavigationLink {
                        LoginView()
                    } label: {
                        Image("login_button")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 190) // tweak as needed
                    }
                    .buttonStyle(.plain)

                    // 4) "or" + Register
                    VStack(spacing: 6) {
                        Text("or")
                            .font(AppFont.playwriteRegular(18))
                            .foregroundColor(.green)
                            .opacity(0.9)

                        NavigationLink {
                            RegisterView()
                        } label: {
                            Text("register")
                                .font(AppFont.playwriteRegular(20))
                                .underline()
                                .foregroundColor(.green)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.top, 6)

                    Spacer().frame(height: 80)
                }
                .padding(.horizontal, 20)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    FrontPageView()
}
