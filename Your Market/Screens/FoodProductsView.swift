//
//  FoodProductsView.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//
import SwiftUI

struct FoodProductsView: View {
    @Environment(\.presentationMode) private var presentationMode
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

            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    ForEach(products) { product in
                        ProductRow(product: product, onCartTap: { goToCart = true })
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.85))
                )
            }
            .padding(.horizontal, 20)


            NavigationLink("", destination: CartView(), isActive: $goToCart)
                .hidden()
        }
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .top, spacing: 0) {
            TopBar(
                onBack: { presentationMode.wrappedValue.dismiss() },
                title: "Choose a product",
                onCart: { goToCart = true }
            )
            .padding(.top, 140)
        }
        .dynamicTypeSize(.medium)
    }
}
#Preview {
    NavigationStack {
        FoodProductsView()
    }
}
