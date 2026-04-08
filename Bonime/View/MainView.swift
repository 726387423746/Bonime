import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Tab("Favorites", systemImage: "star") {
                FavoritesView()
            }
            Tab("Search Anime", systemImage: "play.tv") {
                SearchView()
            }
        }
    }
}
