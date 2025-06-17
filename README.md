# 🌱 Garden App

Welcome to the **Garden App** — a playful SwiftUI demo project built to explore and demonstrate the power of **App Intents** and **App Shortcuts** introduced in iOS 16.

This project accompanies the blog post:
👉 [App Shortcuts: Give Superpowers to Your App in a Matter of Minutes](https://rogy.app/1518)

## 🍏 What’s Inside?
This app simulates a tiny digital garden where you can:
- **Plant seeds**
- **Grow fruits**
- **Pick ripe fruits**, which in turn generate new seeds

All of this is done through the UI *and* by teaching Siri how to do it for you using **App Intents**.

## 📦 Features
- `PlantSeedIntent`: Triggered with no parameters to plant a seed.
- `PickFruitIntent`: Takes a `SeedAppEntity` parameter to pick a ripe fruit.
- `SeedAppEntity`: An `AppEntity` representing fruits, with custom display, search, and suggestions.
- `AppShortcutsProvider`: Registers custom phrases and SF Symbols for Siri & Shortcuts support.

## 🛠️ Technologies Used
- SwiftUI
- App Intents (iOS 16+)
- Combine

## 🪴 License
MIT — use, fork, grow your own version!
