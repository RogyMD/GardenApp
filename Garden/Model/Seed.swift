import Foundation

enum SeedKind: String, CaseIterable, Identifiable {
  case avocado = "🥑"
  case apple = "🍎"
  case pear = "🍐"
  case cherry = "🍒"
  
  var id: String { rawValue }
  var growthDuration: TimeInterval {
    switch self {
    case .avocado: 8
    case .apple: 4
    case .pear: 5
    case .cherry: 3
    }
  }
  var cropCount: Int {
    switch self {
    case .avocado: 3
    case .apple: 2
    case .pear: 2
    case .cherry: 2
    }
  }
}

struct Seed: Identifiable, Equatable {
  var id: UUID
  var kind: SeedKind
  var plantedDate: Date?
  init(
    id: UUID = UUID(),
    kind: SeedKind,
    plantedDate: Date? = nil
  ) {
    self.id = id
    self.kind = kind
    self.plantedDate = plantedDate
  }
  var fruitName: String {
    switch kind {
    case .avocado: "An avocado"
    case .apple: "An apple"
    case .pear: "A pear"
    case .cherry: "A cherry"
    }
  }
}
