import SwiftUI

struct DetailView: View {
    
    let anime: AnimeData
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: anime.images.jpg.imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    case .failure:
                        Image(systemName: "photo")
                    default:
                        EmptyView()
                    }
                }
            }
            .padding(16)
        }
    }
}


extension AnimeData {
    static let sample = AnimeData(
        id: 1,
        title: "Jujutsu Kaisen",
        rank: 35,
        score: 8.65,
        episodes: 24,
        popularity: 24,
        genres: [Genre(malId: 1, name: "Action"), Genre(malId: 10, name: "Fantasy")],
        images: AnimeImage(jpg: Jpg(imageURL: "https://myanimelist.net/images/anime/1171/109222.jpg"))
    )
}

#Preview {
    NavigationStack {
        DetailView(anime: .sample)
    }
}
