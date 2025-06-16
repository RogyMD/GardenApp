import SwiftUI

@MainActor
final class Model: ObservableObject {
  static let shared = Model()
  @Published var bank: SeedContainer = .init(seeds: SeedKind.allCases.map({ Seed(kind: $0) }).shuffled())
  @Published var field: SeedContainer = .init(seeds: [])
  
  func plant(seed: Seed) {
    withAnimation(.bouncy) {
      bank.remove(seed)
    }
    var seed = seed
    seed.plantedDate = Date()
    withAnimation(.easeInOut(duration: seed.kind.growthDuration)) {
      field.append(seed)
    }
  }
  func pick(seed: Seed) {
    guard seed.isFruitReady else { return }
    withAnimation(.bouncy) {
      field.remove(seed)
      bank.append(contentsOf: seed.cropSeeds)
    }
  }
}

extension Seed {
  var cropSeeds: [Seed] {
    (0..<kind.cropCount).map { _ in Seed(kind: kind) }
  }
  var isFruitReady: Bool {
    guard let plantedDate, Date() > plantedDate.addingTimeInterval(kind.growthDuration) else {
      return false
    }
    return true
  }
}
