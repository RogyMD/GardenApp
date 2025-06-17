import AppIntents

struct PlantSeedIntent: AppIntent {
  static var title: LocalizedStringResource = "Plant a Seed"
  func perform() async throws -> some IntentResult & ProvidesDialog {
    guard let seed = await Model.shared.bank.seeds.first else {
      return .result(dialog: IntentDialog("No seeds to plant."))
    }
    await Model.shared.plant(seed: seed)
    return .result(dialog: IntentDialog("\(seed.fruitName) seed was planted for you."))
  }
}
