import Foundation

struct ShopModel: Identifiable, Decodable, Equatable {
    let id: String
    let title: String
    let subtitle: String
    let price: String
    let image: String
    let category: String
}
