//
//  AuthorListView.swift
//  Quotely
//
//  Created by Mykyta on 02.09.26.
//

import SwiftUI

struct AuthorListView: View {
    
    @State private var authors: [Author] = []
    @State private var showErrorAlert: Bool = false
    
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
        
        .alert("Fehler", isPresented: $showErrorAlert) {
            Button("Ok") { }
        } message: {
            Text("Autor:innen konnten leider nicht geladen werden. Bitte versuche es später erneut.")
        }
    }
    
    private func getAuthorsFromAPI() async throws -> [Author] {
        guard let url = URL(string: urlString + ApiKey().quoteKey) else {
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
                showErrorAlert = true
            }
        }
        
    }
}

#Preview {
    AuthorListView()
}
