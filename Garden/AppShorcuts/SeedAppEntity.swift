import AppIntents

struct SeedAppEntity: AppEntity {
  let id: UUID
  let title: String
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
  init(seed: Seed) {
    id = seed.id
    title = seed.fruitName
  }
  static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(name: "Fruit")
  static var defaultQuery = SeedQuery()
}

extension SeedAppEntity {
  struct SeedQuery: EntityStringQuery {
    func entities(for identifiers: [SeedAppEntity.ID]) async throws -> [SeedAppEntity] {
      await Model.shared.field.seeds
        .filter({ identifiers.contains($0.id) })
        .map(SeedAppEntity.init)
    }

    public func entities(matching string: String) async throws -> IntentItemCollection<SeedAppEntity> {
      let matches = await Model.shared.field.seeds
        .filter({ $0.fruitName.localizedCaseInsensitiveContains(string) })
        .map(SeedAppEntity.init)
      return ItemCollection {
        ItemSection<SeedAppEntity>("Found Ripe Fruits", entities: matches)
      }
    }

    public func entities(matching string: String) async throws -> [SeedAppEntity] {
      await Model.shared.field.seeds
        .filter({ $0.fruitName.localizedCaseInsensitiveContains(string) })
        .map(SeedAppEntity.init)
    }

    public func suggestedEntities() async throws -> IntentItemCollection<SeedAppEntity> {
      let ripeFruits = await Model.shared.field.seeds
        .filter(\.isFruitReady)
        .map(SeedAppEntity.init)
      return ItemCollection {
        ItemSection<SeedAppEntity>("Ripe Fruits", entities: ripeFruits)
      }
    }
  }
}

private extension IntentItemSection where Result == SeedAppEntity {
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
