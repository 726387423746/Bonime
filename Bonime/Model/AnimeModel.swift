import Foundation

struct JSONResponse: Codable {
    let data: [AnimeData]
}

struct AnimeData: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let rank: Int?
    let score: Double?
    let episodes: Int?
    let popularity: Int?
    let genres: [Genre]
    let images: AnimeImage
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case title
        case rank
        case score
        case episodes
        case popularity
        case genres
        case images
    }
}

struct Genre: Codable, Hashable  {
    let malId: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case malId = "mal_id"
        case name
    }
}

struct AnimeImage: Codable, Hashable  {
    let jpg: Jpg
}

struct Jpg: Codable, Hashable {
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
    }
}
