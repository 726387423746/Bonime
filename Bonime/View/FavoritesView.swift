import SwiftUI

struct FavoritesView: View {
    @State private var favoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(favoritesViewModel.favoriteAnimes) { favoriteAnime in
                    FavoriteAnimeCardView(data: favoriteAnime)
                }
            }
            .onAppear {
                favoritesViewModel.fetchFavorites()
            }
        }
    }
}

