import StoreKit
import SwiftUI

struct PlantTreeView: View {
  let productId = "app.rogy.garden.plantTree"
  @StateObject var viewModel = PlantTreeViewModel()
  var body: some View {
    ProductView(id: productId) {
      Image(systemName: "tree.fill")
        .resizable()
        .scaledToFit()
        .foregroundStyle(.green)
    }
    .productViewStyle(.large)
    .storeProductTask(for: productId) { state in
      viewModel.taskStateChanged(state)
    }
    .onInAppPurchaseStart { product in
      viewModel.onInAppPurchaseStart()
    }
    .onInAppPurchaseCompletion { _, result in
      viewModel.onInAppPurchaseCompletion(result)
    }
  }
}

extension Product.TaskState {
  var isLoading: Bool {
    switch self {
    case .loading: true
    case .unavailable, .failure, .success: false
    @unknown default: false
    }
  }
}

#Preview("List") {
  List {
    PlantTreeView()
  }
}
#Preview("NavigationStack") {
  NavigationStack {
    PlantTreeView()
      .navigationTitle("Plant a Tree")
  }
}

