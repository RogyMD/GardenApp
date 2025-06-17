import AppIntents

struct GardenAppShorcutsProvider: AppShortcutsProvider {
  public static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: PlantSeedIntent(),
      phrases: [
        "Plant a seed in my \(.applicationName)"
      ],
      shortTitle: "Plant a Seed",
      systemImageName: "apple.meditate"
    )
    AppShortcut(
      intent: PickFruitIntent(),
      phrases: [
        "Pick \(\.$fruitSeed) from my \(.applicationName)",
      ],
      shortTitle: "Pick a Fruit",
      systemImageName: "basket"
    )
  }
}
