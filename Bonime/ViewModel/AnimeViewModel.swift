import Foundation
import Observation

@Observable
class AnimeViewModel {
    var search: String = ""
    var searchResults: [AnimeData] = []
    
    func getAnime() async throws {
        searchResults = try await AnimeService.shared.searchAnime(for: search)
    }
}
