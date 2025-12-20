import SwiftUI
import StoreKit
import OSLog

final class PlantTreeViewModel: ObservableObject {
  let isPlantTreePurchasedKey = "isPlantTreePurchased"
  @Published var isPurchased: Bool
  @Published var isLoading: Bool
  var taskState: Product.TaskState?
  let logger = Logger(subsystem: "app.rogy.Garden", category: "PlantTreeViewModel")
  init() {
    isPurchased = UserDefaults.standard.bool(forKey: isPlantTreePurchasedKey)
    isLoading = true
  }
  func taskStateChanged(_ state: Product.TaskState) {
    taskState = state
    isLoading = state.isLoading
    logger.debug("PlantTreeViewModel.taskStateChanged: \(String(describing: state))")
  }
  func onInAppPurchaseStart() {
    isLoading = true
    logger.debug("PlantTreeViewModel.onInAppPurchaseStart")
  }
  func onInAppPurchaseCompletion(_ result: Result<Product.PurchaseResult, Error>) {
    do {
      let result = try result.get()
      switch result {
      case .success:
        isPurchased = true
        isLoading = false
        UserDefaults.standard.set(true, forKey: isPlantTreePurchasedKey)
      case .userCancelled:
        isLoading = false
      case .pending:
        isLoading = true
      @unknown default:
        isLoading = false
      }
      logger.info("PlantTreeViewModel.onInAppPurchaseCompletion: \(String(describing: result))")
    } catch {
      isLoading = false
      logger.error("PlantTreeViewModel.onInAppPurchaseCompletion: \(error)")
    }
  }
}
