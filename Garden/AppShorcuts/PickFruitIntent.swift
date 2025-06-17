import AppIntents

struct PickFruitIntent: AppIntent {
  static var title: LocalizedStringResource = "Pick a Fruit"
  static var description = IntentDescription("Pick a ripe fruit of your choice.")
  static var parameterSummary: some ParameterSummary {
    Summary("Pick \(\.$fruitSeed) Fruit")
  }
  static var openAppWhenRun: Bool = true
  @Parameter(title: "Fruit Seed")
  var fruitSeed: SeedAppEntity
  init() {}
  func perform() async throws -> some IntentResult & ProvidesDialog {
    guard let seed = await Model.shared.field.seeds.first(where: { $0.id == fruitSeed.id }), seed.isFruitReady else {
      return .result(dialog: IntentDialog("The \(fruitSeed.title) is not ripe yet or has been already picked."))
    }
    await Model.shared.pick(seed: seed)
    return .result(dialog: IntentDialog("The \(seed.fruitName) was picked for you."))
  }
}
