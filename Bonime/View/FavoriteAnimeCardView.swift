import SwiftUI

struct FavoriteAnimeCardView: View {
    
    let data: FavoriteAnimeData
    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: data.imageURL ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 5) {
                Text(data.title ?? "N/A")
            }
        }
    }
}
