import Foundation

// Оставляем для совместимости названия файла
// Если ShopProduct больше не используется — он просто не мешает

struct ShopProduct: Identifiable, Decodable, Equatable {
    let id: String
    let title: String
    let subtitle: String
    let price: String
    let image: String
    let category: String
}
