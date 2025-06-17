import AppIntents

struct PickFruitIntent: AppIntent {
  static var title: LocalizedStringResource = "Pick a Fruit"
  // 1. Describe what this intent does so users can understand its purpose.
  static var description = IntentDescription("Pick a ripe fruit of your choice.")
  // 2. Show how the parameter should appear in the Shortcuts app.
  static var parameterSummary: some ParameterSummary {
    Summary("Pick \(\.$fruitSeed) Fruit")
  }
  // 3. Ensure the app opens when this shortcut is triggered.
  static var openAppWhenRun: Bool = true
  // 4. Declare the parameter that lets users pick a fruit.
  @Parameter(title: "Fruit Seed")
  // 5. Store the selected fruit seed from the user.
  var fruitSeed: SeedAppEntity
  // 6. Required initializer for AppIntent.
  init() {}
  func perform() async throws -> some IntentResult & ProvidesDialog {
    // 7. Try to find the matching fruit and check if it's ripe.
    guard let seed = await Model.shared.field.seeds.first(where: { $0.id == fruitSeed.id }), seed.isFruitReady else {
      // 8. If the fruit isn't ripe or was already picked, return a message.
      return .result(dialog: IntentDialog("The \(fruitSeed.title) is not ripe yet or has been already picked."))
    }
    // 9. Pick the fruit by calling the model.
    await Model.shared.pick(seed: seed)
    // 10. Return a confirmation message.
    return .result(dialog: IntentDialog("The \(seed.fruitName) was picked for you."))
  }
}
