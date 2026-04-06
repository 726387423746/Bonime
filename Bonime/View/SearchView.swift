import SwiftUI

struct SearchView: View {
    
    @State private var animeViewModel = AnimeViewModel()
    var body: some View {
        NavigationStack {
            List {
                ForEach(animeViewModel.searchResults) { data in
                    Text(data.title)
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
