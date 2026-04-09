import SwiftUI

struct SearchView: View {
    
    @State private var animeViewModel = AnimeViewModel()
    @State private var favoritesViewModel = FavoritesViewModel()
    var body: some View {
        NavigationStack {
            List {
                ForEach(animeViewModel.searchResults) { data in
                    AnimeCardView(data: data)
                        .swipeActions(edge: .leading) {
                            Button {
                                let _ = favoritesViewModel.saveAnime(animeData: data)
                            } label: {
                                Label("Favorite", systemImage: "star.fill")
                            }
                            .tint(.green)
                        }
                }
            }
            .searchable(text: $animeViewModel.search, prompt: "search an anime...")
            .onSubmit(of: .search) {
                Task {
                    try await animeViewModel.getAnime()
                }
            }
        }
    }
}
