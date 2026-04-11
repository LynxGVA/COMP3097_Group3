//
//  CategoriesView.swift
//  Your Market
//

import SwiftUI

struct CategoriesView: View {

    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var cartService: CartService

    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 16) {
                VStack(spacing: 14) {
                    NavigationLink {
                        FoodProductsView()
                    } label: {
                        CategoryRow(title: "Food", imageName: "food_image")
                    }

                    NavigationLink {
                        MedicationProductsView()
                    } label: {
                        CategoryRow(title: "Medication", imageName: "medication_image")
                    }

                    NavigationLink {
                        CleaningProductsView()
                    } label: {
                        CategoryRow(title: "Cleaning products", imageName: "cleaning_image")
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.85))
                )
            }
            .padding(.horizontal, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    authManager.logout()
                } label: {
                    Text("Log Out")
                        .font(AppFont.playwriteRegular(16))
                        .foregroundColor(.red)
                }
            }

            ToolbarItem(placement: .principal) {
                Text("Categories")
                    .font(AppFont.playwriteRegular(22))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }

            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    CartView()
                } label: {
                    ZStack(alignment: .topTrailing) {
                        Image("cart")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34, height: 34)

                        // Badge showing number of items in cart
                        if cartService.totalItems > 0 {
                            Text("\(cartService.totalItems)")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 6, y: -6)
                        }
                    }
                }
            }
        }
        .dynamicTypeSize(.medium)
    }
}

private struct CategoryRow: View {
    let title: String
    let imageName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(AppFont.playwriteRegular(20))

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .padding(.vertical, 10)
    }
}

#Preview {
    NavigationStack {
        CategoriesView()
            .environmentObject(AuthManager())
            .environmentObject(CartService())
    }
}
