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
                Text(anime.title)
                    .bold()
                    .font(.title)
                
                HStack {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        VStack {
                            Text("Score")
                            Text(anime.score?.formatted() ?? "N/A")
                                .bold()
                        }
                    }
                    HStack {
                        Image(systemName: "trophy.fill")
                            .foregroundStyle(.orange)
                        VStack {
                            Text("Rank")
                            Text(anime.rank?.formatted() ?? "N/A")
                                .bold()
                        }
                    }
                }
                HStack {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                        VStack {
                            Text("Popularity")
                            Text(anime.popularity?.formatted() ?? "N/A")
                                .bold()
                        }
                    }
                    HStack {
                        Image(systemName: "play.tv.fill")
                            .foregroundStyle(.gray)
                        VStack {
                            Text("Rank")
                            Text("#\(anime.rank?.formatted() ?? "N/A")")
                                .bold()
                        }
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
    DetailView(anime: AnimeData.sample)
}
