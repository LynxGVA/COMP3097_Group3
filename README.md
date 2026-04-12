# Your Market — iOS Shopping App
### COMP3097 | Group 3

---

## ⚠️ Before You Run the App

This app uses **Firebase** for authentication and database storage. You **must** resolve the Firebase packages before building, otherwise the app will not compile.

### Step 1 — Resolve Swift Packages
1. Open `Your Market.xcodeproj` in Xcode
2. Go to **File → Packages → Resolve Package Versions**
3. Wait for Xcode to download all dependencies

### Step 2 — Required Packages (already in project)
The following Firebase packages are included and will be resolved automatically:
- `FirebaseAuth` — user authentication
- `FirebaseFirestore` — real-time database for cart storage
- `FirebaseFirestoreSwift` — Swift Codable support for Firestore

### Step 3 — Run the App
- Select an iPhone simulator (iPhone 16 Pro or later recommended)
- Press **Run (▶)**

> The `GoogleService-Info.plist` is already included in the project and connects automatically to the Firebase backend. No additional setup is needed.

---

## About the App

**Your Market** is an iOS grocery and essentials shopping app built with SwiftUI. Users can browse products across three categories, manage a real-time cart, and place orders.

---

## Features

### Authentication
- **Register** — create a new account with full name, email, and password. After registration the user is returned to the login screen
- **Login** — sign in with email and password
- **Logout** — available from the Categories screen
- **Forgot Password** — sends a password reset email via Firebase

### Categories
- Three product categories: **Food**, **Medication**, **Cleaning Products**
- Cart icon in the top bar shows a live item count badge and the current grand total (including tax)

### Products
- Each category displays a list of products with name, image, and price
- Tap **Add** on any product to add it to your cart
- Adding a product navigates automatically to the cart

### Cart
- Displays all items added by the logged-in user
- **Quantity stepper** — increase or decrease quantity per item. Reducing to 0 removes the item
- **Subtotal** — sum of all item prices
- **Tax (13% HST)** — calculated automatically
- **Total** — subtotal + tax
- **Place Order** — confirms the order and clears the cart
- Cart data is stored in **Firebase Firestore** and syncs in real time across devices

---

## Project Structure

```
Your Market/
├── Screens/
│   ├── FrontPageView.swift         — Landing / welcome screen
│   ├── LoginView.swift             — Login screen
│   ├── RegisterView.swift          — Registration screen
│   ├── CategoriesView.swift        — Main categories screen (post-login)
│   ├── FoodProductsView.swift      — Food products list
│   ├── MedicationProductsView.swift — Medication products list
│   ├── CleaningProductsView.swift  — Cleaning products list
│   └── CartView.swift              — Cart with summary and order placement
├── AuthManager.swift               — Firebase Auth logic (login, register, logout)
├── LocalCartService.swift          — Firebase Firestore cart CRUD
├── UIComponents.swift              — Shared UI components and Product model
├── ContentView.swift               — Root view / navigation flow
├── Your_MarketApp.swift            — App entry point
└── GoogleService-Info.plist        — Firebase configuration (do not delete)
```

---

## Backend — Firebase

| Service | Usage |
|---|---|
| Firebase Auth | User registration, login, logout, password reset |
| Firebase Firestore | Stores each user's cart items in real time under `carts/{userId}/items` |

### Firestore Data Structure
```
carts/
  {userId}/
    items/
      {itemId}/
        productName   : String
        productImage  : String
        price         : Double
        quantity      : Int
        titleStrokeHex: String
```

---

## Tech Stack

- **SwiftUI** — UI framework
- **Firebase Auth** — authentication
- **Firebase Firestore** — NoSQL real-time database
- **Swift Concurrency** (async/await) — all network calls

---

## Group Members — COMP3097 Group 3

| Arshia Moradi | 
| Viktor Grygoriev | 
| Lhekdup Tenzin | 
