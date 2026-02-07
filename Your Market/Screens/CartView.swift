//
//  Untitled.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-06.
//
import SwiftUI

struct CartView: View {
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            StrokeText(
                text: "Your Cart",
                font: AppFont.playwriteRegular(40),
                fill: .white,
                stroke: Color(hex: "058F9E"),
                lineWidth: 1
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            GeometryReader { geo in
                VStack(spacing: 14) {
                    Image("cart_total_box")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 320)

                    Button { } label: {
                        Image("purchase_button")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 280)
                            .overlay {
                                StrokeText(
                                    text: "Purchase!",
                                    font: AppFont.playwriteRegular(28),
                                    fill: .white,
                                    stroke: Color(hex: "058F9E"),
                                    lineWidth: 1
                                )
                                .offset(x:-10, y: -8)
                            }
                    }
                    .buttonStyle(.plain)
                }
                .frame(width: geo.size.width)
                .position(x: geo.size.width / 2, y: geo.size.height - 300)
            }
        }
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .top, spacing: 0) {
            TopBar(onBack: { presentationMode.wrappedValue.dismiss() }, title: "")
                .padding(.top, 140)
        }
    }
}

#Preview {
    NavigationStack {
        CartView()
    }
}





