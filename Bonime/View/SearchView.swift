import SwiftUI

struct SearchView: View {
    
    @State private var animeViewModel = AnimeViewModel()
    var body: some View {
        NavigationStack {
            List {
                ForEach(animeViewModel.searchResults) { data in
                    AnimeCardView(data: data)
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
