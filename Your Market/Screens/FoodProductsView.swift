//
//  FoodProductsView.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//
import SwiftUI

struct FoodProductsView: View {
    var body: some View {
        VStack {
            Text("Food products (placeholder)")
                .font(.title2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .navigationTitle("Food")
        .navigationBarTitleDisplayMode(.inline)
    }

}

#Preview {
    FoodProductsView()
}


