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
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            GeometryReader { geo in
                Image("background_pepper")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.95)
                    .position(x: geo.size.width * 0.75, y: geo.size.height * 0.52)
            }
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 14) {
                    ForEach(products) { product in
                        ProductRow(product: product, onCartTap: { goToCart = true })
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 18)
                .padding(.bottom, 40)
            }

            NavigationLink("", destination: CartView(), isActive: $goToCart)
                .hidden()
        }
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .top, spacing: 0) {
            TopBar(
                onBack: { presentationMode.wrappedValue.dismiss() },
                title: "Choose a product"
            )
            .padding(.top, 140)
        }
    }
}

#Preview {
    NavigationStack {
        CategoriesView()
    }
}

