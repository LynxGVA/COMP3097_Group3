//
//  CategoriesView.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//
import SwiftUI

struct CategoriesView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Categories (placeholder)")
                .font(AppFont.playwriteRegular(20))

            Text("Choose a product")
                .font(AppFont.playwriteRegular(32))
        }

        VStack(spacing: 12) {
            NavigationLink("Food") {
                FoodProductsView()
            }

            NavigationLink("Medication") {
                MedicationProductsView()
            }

            NavigationLink("Cleaning products") {
                CleaningProductsView()
            }
        }
        .padding()
        .navigationTitle("Categories")
    }
}

#Preview {
    NavigationStack {
        CategoriesView()
    }
}

