//
//  AuthorDetailView.swift
//  Quotely
//
//  Created by Mykyta on 02.09.26.
//

import SwiftUI

struct AuthorDetailView: View {
    
    let author: Author
    private let urlString = "https://api.syntax-institut.de/quotes?author="
    @State private var quotes: [Quote] = []
    
    var body: some View {
        List {
            ForEach(quotes) { quote in
                Text(quote.text)
            }
        }
        .task {
            fetchQuotes()
        }
        .navigationTitle(author.name)
    }
    
    //MARK: -API-Calls
    private func getAuthorQuotesFromAPI() async throws -> [Quote] {
        guard let url = URL(string: urlString+author.slug+"&key="+ApiKey().quoteKey+"&limit=15") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Quote].self, from: data)
        
        return result
    }
    
    private func fetchQuotes() {
        Task {
            do {
                self.quotes = try await getAuthorQuotesFromAPI()
            } catch {
                print(error)
            }
        }
    }
    //
    
}

#Preview {
    AuthorDetailView(author: Author(id: "c1e74a21-7e29-4c8e-a6c5-6edc4234b6a3", name: "Albert Einstein", slug: "albert-einstein"))
}

