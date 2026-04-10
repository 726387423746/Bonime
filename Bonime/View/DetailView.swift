import SwiftUI

struct DetailView: View {
    
    let anime: AnimeData
    var body: some View {
        VStack(spacing: 12) {
            Text(anime.title)
                .font(.title)
                .bold()
            AsyncImage(url: URL(string: anime.images.jpg.imageURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                case .failure:
                    Image(systemName: "photo")
                default:
                    EmptyView()
                }
            }
            HStack {
                HStack(spacing: 12) {
                    Image(systemName: "trophy.fill")
                        .foregroundStyle(.orange)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.orange.gradient.secondary)
                        )
                    VStack {
                        Text("Rank")
                            .font(.title2)
                        Text("#\(anime.rank?.formatted() ?? "N/A")")
                            .font(.title2)
                            .bold()
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray.gradient.quinary)
                )
                HStack(spacing: 12) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.yellow.gradient.secondary)
                        )
                    VStack {
                        Text("Score")
                            .font(.title2)
                        Text(anime.score?.formatted() ?? "N/A")
                            .font(.title2)
                            .bold()
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray.gradient.quinary)
                )
            }
            HStack {
                HStack(spacing: 12) {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.red.gradient.secondary)
                        )
                    VStack {
                        Text("Popularity")
                            .font(.title2)
                        Text("#\(anime.popularity?.formatted() ?? "N/A")")
                            .font(.title2)
                            .bold()
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray.gradient.quinary)
                )
                HStack(spacing: 12) {
                    Image(systemName: "play.tv.fill")
                        .foregroundStyle(.blue)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.blue.gradient.secondary)
                        )
                    VStack {
                        Text("Episodes")
                            .font(.title2)
                        Text(anime.episodes?.formatted() ?? "N/A")
                            .font(.title2)
                            .bold()
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray.gradient.quinary)
                )
            }
            
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
        popularity: 115,
        genres: [Genre(malId: 1, name: "Action"), Genre(malId: 10, name: "Fantasy")],
        images: AnimeImage(jpg: Jpg(imageURL: "https://myanimelist.net/images/anime/1171/109222.jpg"))
    )
}

#Preview {
    DetailView(anime: AnimeData.sample)
}
