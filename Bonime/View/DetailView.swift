import SwiftUI

struct DetailView: View {
    let anime: AnimeData
    var body: some View {
        
        ScrollView {
            VStack(spacing: 24) {
                HStack(alignment: .top, spacing: 16) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(anime.title)
                            .font(.title.bold())
                            .kerning(-0.5)
                        HStack(spacing: 15) {
                            Label {
                                Text("Score")
                                    .fontWeight(.semibold)
                            } icon: {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                            }
                            Text(anime.score?.formatted() ?? "N/A")
                                .font(.title3.bold())
                                .monospacedDigit()
                        }
                    }
                    
                }
            }
        }
    }
}
