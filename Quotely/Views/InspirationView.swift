//
//  InspirationView.swift
//  Quotely
//
//  Created by Mykyta on 01.09.26.
//

import SwiftUI

struct InspirationView: View {
    
    @State private var imageArray: [Photo] = []
    @State private var hasError = false
    
    private var urlString: String = "https://api.unsplash.com/search/photos?query=motivation&client_id="
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                
                if hasError {
                    ForEach(0..<8) { _ in
                        Image(systemName: "photo")
                            .frame(height: 150)
                            .frame(maxWidth: .infinity)
                            .clipped()
                    }
                } else {
                    ForEach(imageArray) { photo in
                        AsyncImage(url: URL(string: photo.urls.regular)) { phase in
                            switch phase {
                            case .success(let image):
                                image.resizable()
                                    .frame(height: 150)
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                            case .empty:
                                ProgressView()
                                    .frame(height: 150)
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                            case .failure(_):
                                Image(systemName: "photo")
                                    .frame(height: 150)
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                            @unknown default:
                                Image(systemName: "photo")
                                    .frame(height: 150)
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                            }
                        }
                    }
                }
            }
        }
        .padding(10)
        
        .task {
            fetchImages()
        }
    }
    
    //MARK: -API-Calls
    
    private func getImagesFromAPI() async throws -> [Photo] {
        guard let url = URL(string: urlString+ApiKey().imageKey) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(UnsplashResponse.self, from: data)
        return result.results
    }
    
    private func fetchImages() {
        Task {
            do {
                self.imageArray = try await getImagesFromAPI()
            } catch {
                hasError = true
            }
        }
    }
    //
    
}

#Preview {
    InspirationView()
}
