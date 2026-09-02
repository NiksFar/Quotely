//
//  AuthorListView.swift
//  Quotely
//
//  Created by Mykyta on 02.09.26.
//

import SwiftUI

struct AuthorListView: View {
    
    @State private var authors: [Author] = []
    private let urlString = "https://api.syntax-institut.de/authors?key="
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(authors) { author in
                    
                    NavigationLink {
                        AuthorDetailView(author: author)
                    } label: {
                        Text(author.name)
                    }
                }
            }
            .task {
                fetchAuthors()
            }
            .navigationTitle(Text("Autor:innen"))
        }
        
    }
    
    private func getAuthorsFromAPI() async throws -> [Author] {
        guard let url = URL(string: urlString + ApiKey().key) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Author].self, from: data)
        return result
    }
    
    private func fetchAuthors() {
        Task {
            do {
                self.authors = try await getAuthorsFromAPI()
            } catch {
                print(error)
            }
        }
        
    }
}

#Preview {
    AuthorListView()
}
