//
//  CleaningProductsView.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//
import SwiftUI

struct CleaningProductsView: View {
    var body: some View {
        VStack {
            Text("Cleaning products (placeholder)")
                .font(.title2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .navigationTitle("Cleaning")
        .navigationBarTitleDisplayMode(.inline)
    }

}

#Preview {
    CleaningProductsView()
}
