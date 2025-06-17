// 1. Import AppIntents.
import AppIntents

// 2. Define a provider for app-wide shortcuts using the AppShortcutsProvider protocol.
struct GardenAppShorcutsProvider: AppShortcutsProvider {
  // 3. Return a list of `AppShortcut`s that will be exposed to the system.
  public static var appShortcuts: [AppShortcut] {
    AppShortcut(
      // 4. The AppIntent that will be triggered.
      intent: PlantSeedIntent(),
      // 5. Phrases users can speak to invoke this shortcut.
      phrases: [
        "Plant a seed in my \(.applicationName)"
      ],
      // 6. A short, user-friendly label for the shortcut.
      shortTitle: "Plant a Seed",
      // 7. The SF Symbol used as the icon for this shortcut.
      systemImageName: "apple.meditate"
    )
    AppShortcut(
      intent: PickFruitIntent(),
      phrases: [
        // 1. Define a voice phrase that uses the dynamic `fruitSeed` parameter.
        "Pick \(\.$fruitSeed) from my \(.applicationName)",
      ],
      shortTitle: "Pick a Fruit",
      systemImageName: "basket"
    )
  }
}
