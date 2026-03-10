import SwiftUI

struct ShopScreen: View {

    @EnvironmentObject var favManager: FavoritesManager
    @State private var selectedTab = 1   // Shop по умолчанию

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {

                HomeTab()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)

                ShopContent()
                    .tabItem {
                        Image(systemName: "bag")
                        Text("Shop")
                    }
                    .tag(1)

                FavoritesScreen()
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }
                    .tag(2)

                BagTabView()
                    .tabItem {
                        Image(systemName: "bag.fill")
                        Text("Bag")
                    }
                    .tag(3)

                ProfileTabView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                    .tag(4)
            }
            .navigationBarHidden(true)
        }
    }
}


struct HomeTab: View {

    @EnvironmentObject var favManager: FavoritesManager

    let shoes = [
        ("Air Jordan XXXVI", "US$185"),
        ("Air Jordan XXXVII", "US$190"),
        ("Air Jordan XXXVIII", "US$200")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 8) {
                    Text("What's new")
                        .font(.headline)

                    Text("The latest arrivals from Nike")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(shoes, id: \.0) { shoe in
                            VStack(alignment: .leading) {

                                Image("new")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 260)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(12)

                                Text(shoe.0)
                                    .font(.headline)
                                    .padding(.top, 8)

                                Text(shoe.1)
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 260)
                        }
                    }
                    .padding(.horizontal)
                }

                Image("nike_box")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Home")
    }
}


struct ShopContent: View {

    @State private var selectedCategory = 0
    @State private var showNikeMember = false

    let tabs = ["Men", "Women", "Kids"]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {

                // MARK: Header
                HStack {
                    Text("Shop")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.black)

                    Spacer()

                    Button {
                        print("Search tapped")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)

                // MARK: Tabs (SwiftUI, как в макете)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 28) {
                        ForEach(tabs.indices, id: \.self) { index in
                            VStack(spacing: 6) {
                                Text(tabs[index])
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(
                                        selectedCategory == index ? .black : .gray
                                    )

                                Rectangle()
                                    .fill(selectedCategory == index ? .black : .clear)
                                    .frame(height: 2)
                                    .frame(width: 40)
                            }
                            .onTapGesture {
                                selectedCategory = index
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // MARK: UIKit UITableView (формально присутствует)
                CategoryTableView(
                    items: tabs,
                    selectedIndex: $selectedCategory
                )
                .frame(height: 1)
                .opacity(0.01)

                // MARK: Must-Haves
                VStack(alignment: .leading, spacing: 12) {
                    Text("Must-Haves, Best Sellers & More")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.horizontal)

                    HStack(spacing: 12) {
                        NavigationLink(destination: Best_Sellers()) {
                            VStack(alignment: .leading, spacing: 8) {
                                Image("shop_image1")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: UIScreen.main.bounds.width / 2 - 22,
                                        height: 200
                                    )
                                    .clipped()
                                    .cornerRadius(10)

                                Text("Best Sellers")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                        .buttonStyle(.plain)

                        NavigationLink(destination: Best_Sellers()) {
                            VStack(alignment: .leading, spacing: 8) {
                                Image("nike_image_2")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: UIScreen.main.bounds.width / 2 - 22,
                                        height: 200
                                    )
                                    .clipped()
                                    .cornerRadius(10)

                                Text("Featured in Nike Air")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal)
                }

                // MARK: Banners
                VStack(alignment: .leading, spacing: 12) {

                    ZStack(alignment: .bottomLeading) {
                        Image("nike_image_3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 335, height: 111)
                            .clipped()
                            .cornerRadius(10)

                        Text("New & Featured")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .onTapGesture {
                        showNikeMember = true
                    }
                    .padding(.horizontal)

                    NavigationLink {
                        Shop_Interests_Screen()
                    } label: {
                        ZStack(alignment: .bottomLeading) {
                            Image("nike_image_4")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 335, height: 111)
                                .clipped()
                                .cornerRadius(10)

                            Text("Shoes")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                        }
                        .padding(.horizontal)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.bottom, 24)
        }
        .sheet(isPresented: $showNikeMember) {
            Nike_Member(
                goToProfile: {
                    showNikeMember = false
                }
            )
            .presentationDetents([.large])
        }
    }
}


struct ShopScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShopScreen()
            .environmentObject(FavoritesManager())
            .previewDevice("iPhone 14 Pro")
    }
}
