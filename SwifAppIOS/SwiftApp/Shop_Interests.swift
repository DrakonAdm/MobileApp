import SwiftUI

struct Shop_Interests_Screen: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var favManager: FavoritesManager
    
    let interests = ["work_nike", "work_nike", "work_nike", "work_nike"]
    let recommended = [
        ("Nike Air Force 1", "US$120", "white_shoes"),
        ("Nike Air Max 90", "US$150", "white_shoes"),
        ("Nike Cortez", "US$95", "white_shoes"),
        ("Nike Air Max 270", "US$160", "white_shoes")
    ]
    let nearbyStores = [
        ("Nike By Flatiron", "1.4mi inside", "store"),
        ("Nike Times Square", "2.1mi inside", "store"),
        ("Nike Downtown", "0.8mi inside", "store"),
        ("Nike Uptown", "3.0mi inside", "store")
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                }

                Spacer()

                Text("Shop")
                    .font(.headline)
                    .fontWeight(.semibold)

                Spacer()

                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .border(Color(.systemGray5), width: 1)

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        HStack {
                            Text("Shop My Interests")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            NavigationLink {
                                Best_Sellers()
                                    .environmentObject(favManager)
                            } label: {
                                Text("See all")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal)
                        
                        let interestImages = ["Interests_1", "Interests_2"]
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(interestImages, id: \.self) { imageName in
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 180, height: 220)
                                        .clipped()
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Recommended for You")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        let shoeImages = ["shoes_1", "shoes_2"]
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(Array(recommended.enumerated()), id: \.offset) { index, product in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Image(shoeImages[index % shoeImages.count])
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 180, height: 220)
                                            .clipped()
                                            .cornerRadius(12)
                                        
                                        Text(product.0)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        
                                        Text(product.1)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    .frame(width: 180)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        HStack {
                            Text("Nearby Stores")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                                Text("See all")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            
                        }
                        .padding(.horizontal)
                        
                        let storeImages = ["store_1", "store_2"]
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(Array(nearbyStores.enumerated()), id: \.offset) { index, store in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Image(storeImages[index % storeImages.count])
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 180, height: 220)
                                            .clipped()
                                            .cornerRadius(12)
                                        
                                        Text(store.0)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        
                                        Text(store.1)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    .frame(width: 180)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 8)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard)
    }
}
