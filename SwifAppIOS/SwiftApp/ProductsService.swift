import Foundation

final class ProductsService {

    static let shared = ProductsService()

    private let url = URL(
        string: "https://raw.githubusercontent.com/DrakonAdm/MobileApp/main/products.json"
    )!

    func fetchProducts(
        completion: @escaping ([ShopModel]) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard
                let data = data,
                error == nil,
                let products = try? JSONDecoder().decode([ShopModel].self, from: data)
            else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }

            DispatchQueue.main.async {
                completion(products)
            }
        }.resume()
    }
}
