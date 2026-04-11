import SwiftUI
 
struct FoodProductsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var cartService: CartService
    @State private var goToCart = false
    @State private var addedProduct: String? = nil
 
    private let products: [Product] = [
        Product(name: "Bread",      image: "bread",      price: "5.99$", titleStrokeHex: "4EBD6A"),
        Product(name: "Cheese",     image: "cheese",     price: "8.99$", titleStrokeHex: "4EBD6A"),
        Product(name: "Mayonnaise", image: "mayonnaise", price: "6.99$", titleStrokeHex: "4EBD6A"),
        Product(name: "Milk",       image: "milk",       price: "4.49$", titleStrokeHex: "4EBD6A"),
        Product(name: "Eggs",       image: "eggs",       price: "5.49$", titleStrokeHex: "4EBD6A"),
        Product(name: "Apple",      image: "apple",      price: "2.99$", titleStrokeHex: "4EBD6A"),
        Product(name: "Banana",     image: "banana",     price: "2.49$", titleStrokeHex: "4EBD6A"),
        Product(name: "Tomato",     image: "tomato",     price: "3.49$", titleStrokeHex: "4EBD6A"),
        Product(name: "Rice",       image: "rice",       price: "4.99$", titleStrokeHex: "4EBD6A"),
        Product(name: "Pasta",      image: "pasta",      price: "3.99$", titleStrokeHex: "4EBD6A")
    ]
 
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
 
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    ForEach(products) { product in
                        ProductRow(product: product, onCartTap: {
                            Task { await cartService.addItem(product: product) }
                            addedProduct = product.name
                            goToCart = true
                        })
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.85))
                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 200)
 
            NavigationLink("", destination: CartView(), isActive: $goToCart).hidden()
        }
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .top, spacing: 0) {
            TopBar(
                onBack: { presentationMode.wrappedValue.dismiss() },
                title: "Choose a product",
                onCart: { goToCart = true }
            )
            .padding(.top, 140)
        }
        .dynamicTypeSize(.medium)
    }
}
