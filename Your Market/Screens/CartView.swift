//
//  CartView.swift
//  Your Market
//

import SwiftUI

struct CartView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var cartService: CartService

    @State private var showOrderAlert = false
    @State private var orderPlaced    = false

    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            if cartService.isEmpty {
                // Empty state
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
                        .frame(width: 60, height: 60)
                }

            } else {
                VStack(spacing: 0) {
                    // Items list
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(cartService.items) { item in
                                CartItemRow(item: item)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.9))
                        )
                        .padding(.horizontal, 20)
                        .padding(.bottom, 12)
                    }

                    // Total + Place Order
                    VStack(spacing: 10) {
                        HStack {
                            Text("Total:")
                                .font(AppFont.playwriteRegular(18))
                            Spacer()
                            Text(String(format: "$%.2f", cartService.totalPrice))
                                .font(AppFont.dancingBold(28))
                                .foregroundColor(Color(hex: "4EBD6A"))
                        }
                        .padding(.horizontal, 28)

                        Button {
                            showOrderAlert = true
                        } label: {
                            Text("Place Order")
                                .font(AppFont.playwriteRegular(20))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color(hex: "4EBD6A"))
                                )
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.vertical, 16)
                    .background(Color.white.opacity(0.85))
                }
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
        .alert("Place Order?", isPresented: $showOrderAlert) {
            Button("Confirm") {
                Task {
                    await cartService.clearCart()
                    orderPlaced = true
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text(String(format: "Total: $%.2f\nAre you sure you want to place this order?", cartService.totalPrice))
        }
        .alert("Order Placed! 🎉", isPresented: $orderPlaced) {
            Button("OK") { presentationMode.wrappedValue.dismiss() }
        } message: {
            Text("Your order has been placed successfully.")
        }
    }
}

// MARK: - Cart Item Row

private struct CartItemRow: View {
    let item: CartItem
    @EnvironmentObject var cartService: CartService

    var body: some View {
        HStack(spacing: 12) {
            Image(item.productImage)
                .resizable()
                .scaledToFit()
                .frame(width: 56, height: 56)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.productName)
                    .font(AppFont.playwriteRegular(14))
                    .lineLimit(1)

                Text(String(format: "$%.2f each", item.price))
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Quantity stepper
            HStack(spacing: 8) {
                Button {
                    Task { await cartService.updateQuantity(item, newQuantity: item.quantity - 1) }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                        .font(.title3)
                }

                Text("\(item.quantity)")
                    .font(AppFont.dancingBold(20))
                    .frame(minWidth: 24)

                Button {
                    Task { await cartService.updateQuantity(item, newQuantity: item.quantity + 1) }
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color(hex: "4EBD6A"))
                        .font(.title3)
                }
            }

            Text(String(format: "$%.2f", item.subtotal))
                .font(AppFont.dancingBold(18))
                .foregroundColor(Color(hex: "058F9E"))
                .frame(minWidth: 56, alignment: .trailing)
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    NavigationStack {
        CartView()
            .environmentObject(CartService())
    }
}
