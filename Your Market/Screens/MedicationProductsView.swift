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
        Product(name: "Bandage", image: "bandage", price: "3.99$", titleStrokeHex: "FF7F00"),
        Product(name: "Vitamin C", image: "vitamin_c", price: "6.99$", titleStrokeHex: "FF7F00"),
        Product(name: "Thermometer", image: "thermometer", price: "12.49$", titleStrokeHex: "FF7F00"),
        Product(name: "Face Mask", image: "mask", price: "5.99$", titleStrokeHex: "FF7F00"),
        Product(name: "Hand Sanitizer", image: "sanitizer", price: "4.49$", titleStrokeHex: "FF7F00"),
        Product(name: "Antiseptic Spray", image: "antiseptic", price: "6.49$", titleStrokeHex: "FF7F00"),
        Product(name: "Cotton Pads", image: "cotton", price: "3.49$", titleStrokeHex: "FF7F00"),
        Product(name: "Pain Relief Gel", image: "gel", price: "8.99$", titleStrokeHex: "FF7F00")
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
                        ProductRow(product: product, onCartTap: {
                            goToCart = true
                        })
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut(duration: 0.3), value: products.count)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.85))
                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 200)
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
        MedicationProductsView()
    }
}




