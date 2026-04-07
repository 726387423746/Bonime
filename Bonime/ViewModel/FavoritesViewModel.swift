import CoreData
import Foundation
import Observation

@Observable
class FavoritesViewModel {
    
    let viewContext = PersistenceController.shared.container.viewContext
    var favoriteAnimes: [FavoriteAnimeData] = []
    
    func checkIfExists(identifier: Int) -> Bool {
        let request = FavoriteAnimeData.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id == %d", identifier)
        let count = (try? viewContext.count(for: request)) ?? 0
        return count > 0
    }
    
    func saveAnime(animeData: AnimeData) -> Bool {
        if checkIfExists(identifier: animeData.id) {
            return false
        }
        let newFavoriteAnime = FavoriteAnimeData(context: viewContext)
        newFavoriteAnime.title = animeData.title
        newFavoriteAnime.imageURL = animeData.images.jpg.imageURL
        // it goes like this
        try? viewContext.save()
        return true
    }
}
