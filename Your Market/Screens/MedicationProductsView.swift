//
//  MedicationProductsView.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//
import SwiftUI

struct MedicationProductsView: View {
    var body: some View {
        VStack {
            Text("Medication products (placeholder)")
                .font(.title2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .navigationTitle("Medication")
        .navigationBarTitleDisplayMode(.inline)
    }

}

#Preview {
    MedicationProductsView()
}
