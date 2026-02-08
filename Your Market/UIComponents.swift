//
//  Product.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-06.
//
import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let price: String
    let titleStrokeHex: String
}

struct TopBar: View {
    let onBack: () -> Void
    let title: String
    let onCart: (() -> Void)?

    init(
        onBack: @escaping () -> Void,
        title: String,
        onCart: (() -> Void)? = nil
    ) {
        self.onBack = onBack
        self.title = title
        self.onCart = onCart
    }

    var body: some View {
        GeometryReader { geo in
            let sidePadding: CGFloat = max(10, geo.size.width * 0.04)

            ZStack {
                HStack {
                    Button(action: onBack) {
                        Image("back_button")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 105, height: 30)
                    }
                    .buttonStyle(.plain)
                    .offset(x: -20)

                    Spacer()

                    if let onCart {
                        Button(action: onCart) {
                            Image("cart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 34, height: 34)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, sidePadding)

                if !title.isEmpty {
                    StrokeText(
                        text: title,
                        font: AppFont.playwriteRegular(32),
                        fill: .white,
                        stroke: Color(hex: "058F9E"),
                        lineWidth: 1
                    )
                    .padding(.horizontal, 16)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                }
            }
            .frame(width: geo.size.width, height: 72)
        }
        .frame(height: 72)
    }
}

struct ProductRow: View {
    let product: Product
    let onCartTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            StrokeText(
                text: product.name,
                font: AppFont.dancingBold(48),
                fill: .white,
                stroke: Color(hex: product.titleStrokeHex),
                lineWidth: 1
            )
            .offset(x: -10)
            .padding(.bottom, -25)
            .zIndex(1)

            ProductCardView(product: product, onCartTap: onCartTap)
        }
    }
}

struct ProductCardView: View {
    let product: Product
    let onCartTap: () -> Void

    var body: some View {
        GeometryReader { geo in
            let cardH: CGFloat = 108
            let imageW: CGFloat = 68
            let imageH: CGFloat = 58
            let actionW: CGFloat = min(138, geo.size.width * 0.36)

            HStack(spacing: 14) {
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageW, height: imageH)
                    .padding(.leading, 10)

                HStack(spacing: 0) {
                    StrokeText(
                        text: product.price.replacingOccurrences(of: "$", with: ""),
                        font: AppFont.dancingBold(32),
                        fill: .white,
                        stroke: Color(hex: "058F9E"),
                        lineWidth: 1
                    )

                    StrokeText(
                        text: "$",
                        font: AppFont.dancingBold(32),
                        fill: .white,
                        stroke: Color(hex: "058F9E"),
                        lineWidth: 1
                    )
                }
                .fixedSize(horizontal: true, vertical: false)
                .offset(x: 15, y: 30)

                Spacer(minLength: 8)

                ActionBox(onCartTap: onCartTap)
                    .frame(width: actionW, height: 66)
                    .padding(.trailing, 12)
            }
            .frame(height: cardH)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 19)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 10, y: 10)
            )
        }
        .frame(height: 108)
    }
}

struct ActionBox: View {
    let onCartTap: () -> Void

    var body: some View {
        RoundedRectangle(cornerRadius: 19)
            .strokeBorder(Color.orange, lineWidth: 2)
            .overlay {
                ZStack {
                    Button(action: onCartTap) {
                        Image("cart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 52)
                            .offset(x: -25, y: 4)
                    }
                    .buttonStyle(.plain)

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
