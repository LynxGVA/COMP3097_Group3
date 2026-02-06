//
//  CategoriesView.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//
import SwiftUI

struct CategoriesView: View {
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
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Choose a Category")
                    .font(AppFont.playwriteRegular(22))
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // open cart
                } label: {
                    Image("cart")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34, height: 34)
                }
            }
        }
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
    }
}

