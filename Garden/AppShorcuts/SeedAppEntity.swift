// 1. Import the AppIntents framework to enable AppEntity support.
import AppIntents

// 2. Define a struct conforming to AppEntity, Hashable, and Equatable protocols.
struct SeedAppEntity: AppEntity, Hashable, Equatable {
  // 3. Unique identifier required by AppEntity and Identifiable.
  let id: UUID
  // 4. The name of the fruit shown to the user in the UI.
  let title: String
  // 5. Define how this fruit entity appears in the Shortcuts interface.
  var displayRepresentation: DisplayRepresentation {
    .init(
      title: .init(stringLiteral: title),
      subtitle: "",
      image: DisplayRepresentation.Image(systemName: "tree.fill", isTemplate: true),
      synonyms: [
        .init(stringLiteral: title)
      ]
    )
  }
  // 6. Initialize the AppEntity from your domain model `Seed`.
  init(seed: Seed) {
    id = seed.id
    title = seed.fruitName
  }
  // 7. Display name for the entity type shown in the Shortcuts UI.
  static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(name: "Fruit")
  // 8. Provide a default query used to resolve or suggest fruits.
  static var defaultQuery = SeedQuery()
}

extension SeedAppEntity {
  // 9. Define a query type to resolve and suggest SeedAppEntity values.
  struct SeedQuery: EntityStringQuery {
    // 10. Return fruits that match given IDs.
    func entities(for identifiers: [SeedAppEntity.ID]) async throws -> [SeedAppEntity] {
      // 10.1. Filter the model's seeds by checking which IDs match.
      await Model.shared.field.seeds
        .filter({ identifiers.contains($0.id) })
        .map(SeedAppEntity.init)
    }

    // 11. Return fruits matching a search string as a sectioned UI list.
    public func entities(matching string: String) async throws -> IntentItemCollection<SeedAppEntity> {
      // 11.1. Find seeds whose fruit name matches the input string.
      let matches = await Model.shared.field.seeds
        .filter({ $0.fruitName.localizedCaseInsensitiveContains(string) })
        .map(SeedAppEntity.init)
      // 11.2. Wrap the matches into a section for display.
      return ItemCollection {
        ItemSection<SeedAppEntity>("Found Ripe Fruits", entities: matches)
      }
    }

    // 12. Return a plain list of matching fruits, no UI section.
    public func entities(matching string: String) async throws -> [SeedAppEntity] {
      // 12.1. Simple filtered array of fruits matching the input string.
      await Model.shared.field.seeds
        .filter({ $0.fruitName.localizedCaseInsensitiveContains(string) })
        .map(SeedAppEntity.init)
    }

    // 13. Return suggested fruits as a UI section for default display.
    public func suggestedEntities() async throws -> IntentItemCollection<SeedAppEntity> {
      // 13.1. Filter to include only ripe fruits for suggestions.
      let ripeFruits = await Model.shared.field.seeds
        .filter(\.isFruitReady)
        .map(SeedAppEntity.init)
      // 13.2. Wrap suggestions in a section titled "Ripe Fruits".
      return ItemCollection {
        ItemSection<SeedAppEntity>("Ripe Fruits", entities: ripeFruits)
      }
    }
  }
}

private extension IntentItemSection where Result == SeedAppEntity {
  // 14. Convenience initializer to convert fruits into section items with display info.
  init(_ title: LocalizedStringResource, entities: [SeedAppEntity]) {
    self.init(
      title,
      items: entities.map({
        IntentItem<SeedAppEntity>(
          $0,
          title: $0.localizedStringResource,
          subtitle: $0.displayRepresentation.subtitle,
          image: $0.displayRepresentation.image
        )
      })
    )
  }
}
