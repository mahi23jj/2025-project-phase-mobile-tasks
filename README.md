# 🛒 Ecommerce Product Management App (Flutter + Clean Architecture + BLoC)

This project is a simple yet modular **eCommerce Product Management App** built with **Flutter** using **Clean Architecture principles**, **BLoC state management**, and complete **unit testing**.

## 📦 Features

- ✅ Create a new product
- 🗑️ Delete a product
- ✏️ Update a product
- 📃 View all products
- 🔍 View single product details

---

## 🏗️ Project Architecture – Clean Architecture

```lib/
├── core/ # Common entities, failures, and utilities
│ ├── error/
| ├── platform/
│ └── usecases/
├── features/
│ └── product/
│ ├── data/
│ │ ├── models/
│ │ ├── repositories/
│ │ └── datasources/
│ ├── domain/
│ │ ├── entities/
│ │ ├── repositories/
│ │ └── usecases/
│ ├── presentation/
│ │ ├── bloc/
│ │ └── pages/
├── main.dart
test/
└── (unit + widget tests)
```

## 🔁 Performed Task in this Separation

### 🗂️ Data Layer Remote DataSource
- Implements Remote data source implementation
- Implements test for Remote data source implementation
---

## 🧪 Testing

All business logic is tested using `blocTest` and mocks.

✅ Covered tests:
- Product creation (success + failure)
- Product deletion (success + failure)
- Product update (success + failure)
- Single product retrieval
- Full product list retrieval
- Model serialization & deserialization

📁 Test Folder Structure:
```
test/
└── features/
└── product/
├── data/
├── domain/
└── presentation/
```

🚀 Getting Started
✅ Prerequisites
Flutter SDK

Dart >= 3.0

flutter_bloc, mocktail, dartz, etc. installed

🛠️ Run Locally
git clone https://github.com/mahi23jj/2025-project-phase-mobile-tasks.git
cd ecommerce_bloc_clean
flutter pub get
flutter run

🧪 Run Tests
flutter test
