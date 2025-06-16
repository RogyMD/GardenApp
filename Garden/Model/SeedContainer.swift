import Foundation

struct SeedContainer {
  var seeds: [Seed]
  var seedIds: Set<Seed.ID>
  init(seeds: [Seed]) {
    self.seeds = seeds
    self.seedIds = .init(seeds.map(\.id))
  }
  mutating func append(contentsOf seeds: [Seed]) {
    for seed in seeds {
      append(seed)
    }
  }
  mutating func append(_ seed: Seed) {
    guard seedIds.contains(seed.id) == false else {
      if let index = seeds.firstIndex(where: { $0.id == seed.id}) {
        seeds.remove(at: index)
        seeds.insert(seed, at: index)
      }
      return
    }
    seedIds.insert(seed.id)
    seeds.append(seed)
  }
  mutating func remove(_ seed: Seed) {
    guard seedIds.contains(seed.id) else {
      return
    }
    seedIds.remove(seed.id)
    guard let index = seeds.firstIndex(of: seed) else {
      return
    }
    seeds.remove(at: index)
  }
}
