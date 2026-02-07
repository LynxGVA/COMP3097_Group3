//
//  MedicationProductsView.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//
import SwiftUI

struct MedicationProductsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var goToCart = false

    private let products: [Product] = [
        Product(name: "Cough syrup", image: "cough_syrup", price: "9.99$", titleStrokeHex: "FF7F00"),
        Product(name: "Painkillers", image: "painkillers", price: "7.49$", titleStrokeHex: "FF7F00"),
        Product(name: "Bandage", image: "bandage", price: "3.99$", titleStrokeHex: "FF7F00")
    ]

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            GeometryReader { geo in
                Image("background_medicine")
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

