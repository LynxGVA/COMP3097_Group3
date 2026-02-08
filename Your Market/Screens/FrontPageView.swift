//
//  FrontPageVoew.swift
//  Your Market
//
//  Created by Lhekdup Tenzin on 2026-02-06.
//
import SwiftUI

struct FrontPageView: View {
    @Binding var path: NavigationPath

    var body: some View {
        ZStack {
            Image("frontpage_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Spacer().frame(height: 60)

                Image("yourmarket_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220)
                    .padding(.top, 10)

                Spacer()

                Button {
                    path.append(Route.login)
                } label: {
                    Image("login_button")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 190)
                }
                .buttonStyle(.plain)

                VStack(spacing: 6) {
                    Text("or")
                        .font(AppFont.playwriteRegular(18))
                        .foregroundColor(.green)
                        .opacity(0.9)

                    Button {
                        path.append(Route.register)
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
        .dynamicTypeSize(.medium)
    }
}

#Preview {
    NavigationStack {
        FrontPageView(path: .constant(NavigationPath()))
    }
}

