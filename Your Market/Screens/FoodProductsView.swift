//
//  FoodProductsView.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//
import SwiftUI

struct FoodProductsView: View {
    @State private var goToCart = false

    private let products: [Product] = [
        Product(name: "Bread", image: "bread", price: "5.99$", titleStrokeHex: "4EBD6A"),
        Product(name: "Cheese", image: "cheese", price: "8.99$", titleStrokeHex: "4EBD6A"),
        Product(name: "Mayonnaise", image: "mayonnaise", price: "6.99$", titleStrokeHex: "4EBD6A")
    ]

    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 16) {
                VStack(spacing: 14) {
                    ForEach(products) { product in
                        ProductRow(product: product, onCartTap: { goToCart = true })
                    }
                }
                .padding()
                .padding(.top, 8)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.85))
                )
            }
            .padding(.horizontal, 20)

            NavigationLink(destination: CartView(), isActive: $goToCart) { EmptyView() }
                .hidden()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Choose a product")
                    .font(AppFont.playwriteRegular(22))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button { goToCart = true } label: {
                    Image("cart")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34, height: 34)
                }
            }
        }
        .dynamicTypeSize(.medium)
    }
}
