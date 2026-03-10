import SwiftUI
import UIKit

struct Best_Sellers: View {
    @EnvironmentObject var favManager: FavoritesManager
    @EnvironmentObject var bagManager: BagManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var allProducts: [ShopModel] = []


    @State private var selectedCategory = "Clothes"

    let categories = ["Clothes", "Socks", "Accessories & Equipment"]
    
    var filteredProducts: [ShopModel] {
        allProducts.filter { $0.category == selectedCategory }
    }


    var body: some View {
        VStack(spacing: 0) {

            // MARK: Top Bar
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                }

                Spacer()

                Text("Best Sellers")
                    .font(.headline)

                Spacer()

                HStack(spacing: 20) {
                    Image(systemName: "plus")
                    Image(systemName: "square.and.arrow.up")
                }
            }
            .padding()

            Divider()

            // MARK: Categories
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    ForEach(categories, id: \.self) { cat in
                        VStack {
                            Text(cat)
                                .foregroundColor(cat == selectedCategory ? .black : .gray)
                                .fontWeight(cat == selectedCategory ? .semibold : .regular)
                        }
                        .onTapGesture {
                            selectedCategory = cat
                        }
                    }
                }
                .padding()
            }

            Divider()

            // MARK: Products Grid
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 24
                ) {
                    ForEach(filteredProducts, id: \.id) { product in
                        VStack(alignment: .leading, spacing: 6) {

                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: UIImage(named: product.image) ?? UIImage())
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                                    .cornerRadius(12)

                                Button {
                                    favManager.toggle(product)
                                } label: {
                                    Image(systemName: favManager.isFavorite(product) ? "heart.fill" : "heart")
                                        .foregroundColor(favManager.isFavorite(product) ? .red : .black)
                                        .padding(10)
                                        .background(Color.white.opacity(0.9))
                                        .clipShape(Circle())
                                        .padding(8)
                                }
                            }

                            Text("Bestseller")
                                .font(.caption)
                                .foregroundColor(.orange)

                            Text(product.title)
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Text(product.subtitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(1)

                            Text(product.price)
                                .font(.caption)
                        }
                    }

                }
                .padding()
                .padding(.bottom, 100)
            }
        }
        .onAppear {
                ProductsService.shared.fetchProducts { products in
                    self.allProducts = products
                }
            }
        .navigationBarHidden(true)
    }
}

struct Best_Sellers_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Best_Sellers()
                .environmentObject(FavoritesManager())
                .environmentObject(BagManager())
        }
    }
}
