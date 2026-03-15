//
//  LocalCartService.swift
//  Your Market
//
//  Created by Arshia Moradi on 2026-03-15.
//

import Foundation
import Combine
// Represents one item in the cart
struct CartItem: Identifiable, Codable {
    var id: String { productId }
    var productId: String
    var name: String
    var price: Double
    var quantity: Int
}

class LocalCartService: ObservableObject {

    @Published var items: [CartItem] = []

    private let key = "saved_cart"

    init() {
        load()
    }

    // Read cart from device storage on launch
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([CartItem].self, from: data)
        else { return }
        items = decoded
    }

    // Save cart to device storage after every change
    private func save() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func addToCart(_ product: Product) {
        if let index = items.firstIndex(where: { $0.productId == product.id.uuidString }) {
            items[index].quantity += 1
        } else {
            let newItem = CartItem(
                productId: product.id.uuidString,
                name: product.name,
                price: Double(product.price.replacingOccurrences(of: "$", with: "")) ?? 0,
                quantity: 1
            )
            items.append(newItem)
        }
        save()
    }

    func removeFromCart(productId: String) {
        items.removeAll { $0.productId == productId }
        save()
    }

    func clearCart() {
        items = []
        UserDefaults.standard.removeObject(forKey: key)
    }

    // Total price of everything in the cart
    var total: Double {
        items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
}
