import SwiftUI

struct AnimeCardView: View {
    
    let data: AnimeData
    var body: some View {
        HStack(alignment: .top, spacing: 5.5){
            // IMAGE
            AsyncImage(url: URL(string: data.images.jpg.imageURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                case .failure:
                    Image(systemName: "photo")
                default:
                    EmptyView()
                }
            }
            // Title, Score, Episodes
            VStack(alignment: .leading) {
                Text(data.title)
                Text("Score: \(data.score != nil ? String(data.score!) : "N/A")")
                Text("Episodes: \(data.episodes != nil ? String(data.episodes!) : "N/A")")
            }
        }
    }
}
