import AppIntents

struct GardenAppShortcutsProvider: AppShortcutsProvider {
  @AppShortcutsBuilder
  public static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: PickFruitIntent(),
      phrases: [
        "Pick \(\.$fruitSeed) from my \(.applicationName)",
      ],
      shortTitle: "Pick a Fruit",
      systemImageName: "basket"
    )
    AppShortcut(
      intent: PlantSeedIntent(),
      phrases: [
        "Plant a seed in my \(.applicationName)"
      ],
      shortTitle: "Plant a Seed",
      systemImageName: "apple.meditate"
    )
  }
}
