import Foundation

class AnimeService {
    static let shared = AnimeService()
    private init() {
        components.scheme = "https"
        components.host = "api.jikan.moe"
        components.path = "/v4/anime"
    }
    private var components = URLComponents()
    
    func searchAnime(for query: String) async throws -> [AnimeData] {
        components.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let jsonResponse = try JSONDecoder().decode(JSONResponse.self, from: data)
        return jsonResponse.data
    }
}
