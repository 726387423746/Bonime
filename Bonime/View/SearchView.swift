import SwiftUI

struct SearchView: View {
    
    @State var animeModel = AnimeViewModel()
    var body: some View {
        NavigationStack {
            Text("Hello, this is SearchView!")
        }
    }
}
