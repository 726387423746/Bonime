import CoreData
import Foundation
import Observation

@Observable
class FavoritesViewModel {
    
    let viewContext = PersistenceController.shared.container.viewContext
    var favoriteAnimes: [FavoriteAnimeData] = []
    
    func fetchFavorites() {
        let request = FavoriteAnimeData.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \FavoriteAnimeData.title, ascending: true)]
        do {
            favoriteAnimes = try viewContext.fetch(request)
        } catch {
            print("Fetch failed: \(error)")
        }
    }
    
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
        newFavoriteAnime.id = Int64(animeData.id)
        newFavoriteAnime.title = animeData.title
        newFavoriteAnime.imageURL = animeData.images.jpg.imageURL
        if let score = animeData.score { newFavoriteAnime.score = score }
        if let episodes = animeData.episodes { newFavoriteAnime.episodes = Int16(episodes) }
        
        do {
            try viewContext.save()
            fetchFavorites()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            return false
        }
        return true
    }
    
    func deleteAnime(anime: FavoriteAnimeData) {
        viewContext.delete(anime)
        do {
            try viewContext.save()
            fetchFavorites()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
