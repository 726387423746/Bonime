import SwiftUI

struct FavoritesView: View {
    @State private var favoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(favoritesViewModel.favoriteAnimes) { favoriteAnime in
                    FavoriteAnimeCardView(data: favoriteAnime)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                let _ = favoritesViewModel.deleteAnime(anime: favoriteAnime)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .onAppear {
                favoritesViewModel.fetchFavorites()
            }
        }
    }
}

