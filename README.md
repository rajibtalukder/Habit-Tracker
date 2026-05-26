# Habitly — Modern iOS Habit Tracker

Habitly is an elegant, minimalist routine tracker built from scratch using SwiftUI. The project is designed to showcase clean software engineering practices, fluid animations, and robust local data persistence on iOS.

---

## 📱 App Preview

<p align="center">
  <img src="https://github.com/rajibtalukder/Habit-Tracker/blob/main/Habit%20Tracker/Screenshots/Dashboard.png" width="300" alt="Habitly App Dashboard"/>
  <img src="https://github.com/rajibtalukder/Habit-Tracker/blob/main/Habit%20Tracker/Screenshots/HabitAdd.png" width="300" alt="Habitly App Dashboard"/>
</p>

---

## 🛠️ Tech Stack & Architecture
This project is built fully natively to demonstrate a mastery of standard iOS architecture patterns:

* **Framework:** SwiftUI (100% Declarative Interface)
* **Architecture:** MVVM (Model-View-ViewModel) separating presentation from layout boundaries
* **Data Persistence:** `UserDefaults` combined with Swift's `Codable` protocol for local storage
* **State Management:** Fully reactive using `@StateObject`, `@ObservedObject`, and `@Published` stream broadcasters

## ✨ Key Features
* **Progress Visualization:** An automated, native vector progress ring displaying daily performance ratios.
* **Dynamic Management:** Contextual menu engine enabling deep operations like swipe gestures to remove habits.
* **Custom Customization Engine:** Dynamic creation flow sheet allowing users to allocate specific tracking titles, color palettes, and custom SF Symbols.
* **Smart Persisted Storage:** Data updates asynchronously register changes to local storage instantly without stalling the foreground main thread thread.
