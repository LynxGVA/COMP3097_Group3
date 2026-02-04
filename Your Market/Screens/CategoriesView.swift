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
