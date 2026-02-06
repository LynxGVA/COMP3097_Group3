//
//  FoodProductsView.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//
import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let price: String
}

struct FoodProductsView: View {
    @Environment(\.dismiss) private var dismiss

    private let products: [Product] = [
        Product(name: "Bread", image: "bread", price: "5.99$"),
        Product(name: "Cheese", image: "cheese", price: "8.99$"),
        Product(name: "Mayonnaise", image: "mayonnaise", price: "6.99$")
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
                        ProductRow(product: product)
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 18)
                .padding(.bottom, 40)
            }
        }
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .top, spacing: 0) {
            TopBar(onBack: { dismiss() })
                .padding(.top, 140)
        }
    }
}

struct TopBar: View {
    let onBack: () -> Void

    var body: some View {
        ZStack {
            HStack {
                Button(action: onBack) {
                    Image("back_button")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 105, height: 30)
                }
                .buttonStyle(.plain)

                Spacer()
            }
            .padding(.horizontal, -15)

            StrokeText(
                text: "Choose a product",
                font: AppFont.playwriteRegular(32),
                fill: .white,
                stroke: Color(hex: "058F9E"),
                lineWidth: 1
            )
            .padding(.leading, 10)
            .padding(.trailing, 16)
        }
        .frame(height: 72)
    }
}

struct ProductRow: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            StrokeText(
                text: product.name,
                font: AppFont.dancingBold(48),
                fill: .white,
                stroke: Color(hex: "4EBD6A"),
                lineWidth: 1
            )
            .padding(.leading, -10)
            .padding(.bottom, -25)
            .zIndex(1)

            ProductCardView(product: product)
        }
    }
}

struct ProductCardView: View {
    let product: Product

    var body: some View {
        HStack(spacing: 14) {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .frame(width: 68, height: 58)
                .padding(.leading, 10)

            StrokeText(
                text: product.price,
                font: AppFont.dancingBold(32),
                fill: .white,
                stroke: Color(hex: "058F9E"),
                lineWidth: 1
            )
            .offset(y: 30)

            Spacer(minLength: 8)

            ActionBox()
                .padding(.trailing, 12)
        }
        .frame(height: 108)
        .background(
            RoundedRectangle(cornerRadius: 19)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 10, y: 10)
        )
    }
}

struct ActionBox: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 19)
            .strokeBorder(Color.orange, lineWidth: 2)
            .frame(width: 138, height: 66)
            .overlay {
                ZStack {
                    Image("cart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 52)
                        .offset(x: -25, y: 4)

                    Text("Add")
                        .font(AppFont.dancingBold(24))
                        .foregroundStyle(Color(hex: "4EBD6A"))
                        .offset(x: -20, y: -20)

                    Text("Remove")
                        .font(AppFont.dancingMedium(16))
                        .foregroundStyle(Color.red)
                        .underline(true, color: .red)
                        .offset(x: 30, y: 18)
                }
            }
    }
}

struct StrokeText: View {
    let text: String
    let font: Font
    let fill: Color
    let stroke: Color
    let lineWidth: CGFloat

    var body: some View {
        ZStack {
            Text(text).font(font).foregroundStyle(stroke).offset(x: -lineWidth, y: 0)
            Text(text).font(font).foregroundStyle(stroke).offset(x: lineWidth, y: 0)
            Text(text).font(font).foregroundStyle(stroke).offset(x: 0, y: -lineWidth)
            Text(text).font(font).foregroundStyle(stroke).offset(x: 0, y: lineWidth)
            Text(text).font(font).foregroundStyle(fill)
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self = Color(red: r, green: g, blue: b)
    }
}

#Preview {
    NavigationStack {
        FoodProductsView()
    }
}
