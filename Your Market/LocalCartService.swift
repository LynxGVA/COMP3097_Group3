

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Combine

struct CartItem: Identifiable, Codable {
    @DocumentID var id: String?
    var productName: String
    var productImage: String
    var price: Double
    var quantity: Int
    var titleStrokeHex: String

    var subtotal: Double { price * Double(quantity) }
}

@MainActor
class CartService: ObservableObject {

    @Published var items: [CartItem] = []
    @Published var isLoading = false

    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    var totalItems: Int    { items.reduce(0) { $0 + $1.quantity } }
    var totalPrice: Double { items.reduce(0.0) { $0 + $1.subtotal } }
    var isEmpty: Bool      { items.isEmpty }

    // MARK: - Start listening (call after login)

    func startListening() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        listener = db
            .collection("carts")
            .document(uid)
            .collection("items")
            .addSnapshotListener { [weak self] snapshot, _ in
                guard let self, let snapshot else { return }
                self.items = snapshot.documents.compactMap {
                    try? $0.data(as: CartItem.self)
                }
            }
    }

    // MARK: - Stop listening (call after logout)

    func stopListening() {
        listener?.remove()
        listener = nil
        items = []
    }

    // MARK: - Add item

    func addItem(product: Product) async {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let ref = db.collection("carts").document(uid).collection("items")

        // If already in cart → increment quantity
        if let existing = items.first(where: { $0.productName == product.name }),
           let docId = existing.id {
            do {
                try await ref.document(docId).updateData(["quantity": existing.quantity + 1])
            } catch {
                print("[CartService] increment error: \(error)")
            }
            return
        }

        // New item → insert
        let price = Double(product.price.replacingOccurrences(of: "$", with: "")) ?? 0
        let newItem = CartItem(
            productName:    product.name,
            productImage:   product.image,
            price:          price,
            quantity:       1,
            titleStrokeHex: product.titleStrokeHex
        )
        do {
            try ref.addDocument(from: newItem)
        } catch {
            print("[CartService] addItem error: \(error)")
        }
    }

    // MARK: - Remove item

    func removeItem(_ item: CartItem) async {
        guard let uid = Auth.auth().currentUser?.uid,
              let docId = item.id else { return }
        do {
            try await db
                .collection("carts").document(uid)
                .collection("items").document(docId)
                .delete()
        } catch {
            print("[CartService] removeItem error: \(error)")
        }
    }

    // MARK: - Update quantity

    func updateQuantity(_ item: CartItem, newQuantity: Int) async {
        guard newQuantity >= 1 else { await removeItem(item); return }
        guard let uid = Auth.auth().currentUser?.uid,
              let docId = item.id else { return }
        do {
            try await db
                .collection("carts").document(uid)
                .collection("items").document(docId)
                .updateData(["quantity": newQuantity])
        } catch {
            print("[CartService] updateQuantity error: \(error)")
        }
    }

    // MARK: - Clear entire cart

    func clearCart() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        do {
            let snapshot = try await db
                .collection("carts").document(uid)
                .collection("items").getDocuments()
            for doc in snapshot.documents {
                try await doc.reference.delete()
            }
        } catch {
            print("[CartService] clearCart error: \(error)")
        }
    }
}
