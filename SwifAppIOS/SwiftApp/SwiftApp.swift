import SwiftUI

@main
struct SwiftApp: App {

    @StateObject private var favoritesManager = FavoritesManager()

    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(favoritesManager)
        }
    }
}
