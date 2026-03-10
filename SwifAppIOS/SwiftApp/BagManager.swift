import SwiftUI

final class BagManager: ObservableObject {
    @Published var items: [ShopProduct] = []

    func add(_ product: ShopProduct) {
        items.append(product)
    }
}
