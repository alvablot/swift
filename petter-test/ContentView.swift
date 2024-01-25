import SwiftUI

struct CatThumbnail: Identifiable {
    let id = UUID()
    let url: String
}

struct ContentView: View {
    private let apiKey = "b15c050e-7d9d-4993-a300-fa79c5e86c99"
    private let apiUrl = "https://api.thecatapi.com/v1/images/search"
    @State private var catThumbnails: [CatThumbnail] = []

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(catThumbnails) { catThumbnail in
                        NavigationLink(destination: FullImageView(imageURL: catThumbnail.url)) {
                            ThumbnailView(url: catThumbnail.url)
                        }
                    }
                }
                .padding(10)
            }
            .onAppear {
                getCatThumbnails()
            }
            .navigationTitle("Cat Thumbnails")
        }
    }

    private func getCatThumbnails() {
        guard var urlComponents = URLComponents(string: apiUrl) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "limit", value: "30")
        ]

        guard let url = urlComponents.url else { return }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let catData = try JSONDecoder().decode([CatImageData].self, from: data)
                    catThumbnails = catData.map { CatThumbnail(url: $0.url) }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

struct CatImageData: Codable {
    let url: String
}

struct FullImageView: View {
    let imageURL: String

    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
            @unknown default:
                EmptyView()
            }
        }
        .navigationTitle("Full Image")
    }
}

struct ThumbnailView: View {
    let url: String

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CatThumbnailApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
