import SwiftUI

struct DetailView: View {
    let anime: AnimeData
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // MARK: - Top Card
                HStack(alignment: .top, spacing: 16) {
                    
                    // Left side - Title, Score, Rank, Genres
                    VStack(alignment: .leading, spacing: 12) {
                        Text(anime.title)
                            .font(.title2.bold())
                            .kerning(-0.3)
                        
                        // Score and Rank
                        HStack(spacing: 12) {
                            // Score badge
                            HStack(spacing: 6) {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Score")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    Text(anime.score != nil ? String(format: "%.2f", anime.score!) : "N/A")
                                        .font(.subheadline.bold())
                                        .monospacedDigit()
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            // Rank badge
                            HStack(spacing: 6) {
                                Image(systemName: "trophy.fill")
                                    .foregroundStyle(.orange)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Rank")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    Text(anime.rank != nil ? "#\(anime.rank!)" : "N/A")
                                        .font(.subheadline.bold())
                                        .monospacedDigit()
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        // Genres
                        FlowLayout(spacing: 8) {
                            ForEach(anime.genres, id: \.malId) { genre in
                                Text(genre.name)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.12))
                                    .foregroundStyle(.blue)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Right side - Image
                    AsyncImage(url: URL(string: anime.images.jpg.imageURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 140, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(20)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.06), radius: 10, y: 4)
                
                // MARK: - Bottom Stats
                HStack(spacing: 14) {
                    // Popularity card
                    HStack(spacing: 10) {
                        Image(systemName: "heart.fill")
                            .font(.title3)
                            .foregroundStyle(.red)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Popularity")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text(anime.popularity != nil ? "\(anime.popularity!)" : "N/A")
                                .font(.title3.bold())
                                .monospacedDigit()
                        }
                        Spacer()
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    // Episodes card
                    HStack(spacing: 10) {
                        Image(systemName: "tv.fill")
                            .font(.title3)
                            .foregroundStyle(.blue)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Episodes")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text(anime.episodes != nil ? "\(anime.episodes!)" : "N/A")
                                .font(.title3.bold())
                                .monospacedDigit()
                        }
                        Spacer()
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .padding(16)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Flow Layout for Genre Chips
struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = layout(in: proposal.width ?? 0, subviews: subviews)
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = layout(in: bounds.width, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y), proposal: .unspecified)
        }
    }
    
    private func layout(in width: CGFloat, subviews: Subviews) -> (size: CGSize, positions: [CGPoint]) {
        var positions: [CGPoint] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > width, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            positions.append(CGPoint(x: x, y: y))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }
        
        return (CGSize(width: width, height: y + rowHeight), positions)
    }
}
