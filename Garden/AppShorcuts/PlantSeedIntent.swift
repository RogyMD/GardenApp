// 1. Import AppIntents.
import AppIntents

// 2. Define a new AppIntent.
struct PlantSeedIntent: AppIntent {
  // 3. Set a title shown to the user.
  static var title: LocalizedStringResource = "Plant a Seed"
  /// 4. Perform the seed-planting action and return a result.
  func perform() async throws -> some IntentResult & ProvidesDialog {
    // 5. Check if there's at least one seed available to plant.
    guard let seed = await Model.shared.bank.seeds.first else {
      // 6. If there are no seeds, return a dialog message to the user.
      return .result(dialog: IntentDialog("No seeds to plant."))
    }
    // 7. Plant the first available seed.
    await Model.shared.plant(seed: seed)
    // 8. Return a dialog confirming the planting action.
    return .result(dialog: IntentDialog("\(seed.fruitName) seed was planted for you."))
  }
}
