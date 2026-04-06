import SwiftUI

struct AnimeCardView: View {
    
    let data: AnimeData
    var body: some View {
        HStack(alignment: .top, spacing: 5.5){
            AsyncImage(url: URL(string: data.images.jpg.imageURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "photo")
                default:
                    EmptyView()
                }
            }
            VStack {
                Text(data.title)
            }
            
        }
    }
}
