//
//  CartView.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-06
import SwiftUI

struct CartView: View {
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 16) {
                StrokeText(
                    text: "Your cart is empty",
                    font: AppFont.dancingMedium(50),
                    fill: .white,
                    stroke: Color(hex: "4EBD6A"),
                    lineWidth: 1
                )

                Image("cart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)

                
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.horizontal, 12)
            }


        }
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .top, spacing: 0) {
            TopBar(
                onBack: { presentationMode.wrappedValue.dismiss() },
                title: "My Cart"
            )
            .padding(.top, 140)
        }
        .dynamicTypeSize(.medium)
    }
}

#Preview {
    NavigationStack {
        CartView()
    }
}
