import SwiftUI

struct GardenView: View {
  @ObservedObject var model: Model = .shared
  @State var isPlantTreePresented = false
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 12) {
        Label("Gardening is Fun", systemImage: "apple.meditate")
          .font(.title)
        seedsGrid(
          title:"🫙Seeds Bank",
          seeds: model.bank.seeds,
          background: Color(uiColor: .secondarySystemBackground),
          action: model.plant
        )
        Button("Plant a Tree", systemImage: "tree.fill") {
          isPlantTreePresented = true
        }
        .buttonStyle(.borderedProminent)
        Divider()
        Section {
          seedsGrid(
            title: "🌱Garden",
            seeds: model.field.seeds,
            background: .brown,
            action: model.pick
          )
        }
      }
    }
    .padding(.horizontal)
    .toolbar {
      ToolbarItem(placement: .principal) {
        Image(systemName: "tree.fill")
          .font(.title3)
          .foregroundStyle(.green)
          .padding(.top)
      }
    }
    .onReceive(model.$field.map(\.seeds).removeDuplicates()) { _ in
      GardenAppShortcutsProvider.updateAppShortcutParameters()
    }
    .sheet(isPresented: $isPlantTreePresented) {
      NavigationStack {
        PlantTreeView()
          .navigationTitle("Plant a Tree")
      }
    }
  }
  
  func seedsGrid(title: String, seeds: [Seed], background: Color, action: @escaping (Seed) -> Void) -> some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.title2)
      
      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 12) {
        ForEach(seeds) { seed in
          VStack(spacing: 4) {
            Button(seed.kind.rawValue) {
              action(seed)
            }
            .font(.title)
            
            if let plantedDate = seed.plantedDate {
              ProgressView(
                timerInterval: plantedDate...plantedDate.addingTimeInterval(seed.kind.growthDuration),
                countsDown: false
              )
              .labelsHidden()
              .progressViewStyle(.linear)
            }
          }
          .multilineTextAlignment(.center)
          .transition(.growth)
        }
      }
      .padding()
      .background {
        background
          .cornerRadius(10)
      }
    }
  }
}

extension AnyTransition {
  static let growth = AnyTransition
    .scale(scale: 0.4, anchor: .bottom)
    .combined(with: .move(edge: .bottom))
    .combined(with: .opacity)
}

#Preview {
  NavigationStack {
    GardenView()
  }
}
