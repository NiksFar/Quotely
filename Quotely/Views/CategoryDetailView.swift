//
//  CategoryDetailView.swift
//  Quotely
//
//  Created by Mykyta on 01.09.26.
//

import SwiftUI

struct CategoryDetailView: View {
    
    let categoryName: String
    let url = "https://api.syntax-institut.de/quotes?category="
    @State private var quotes: [Quote] = []
    
    var body: some View {
        
        List {
            ForEach(quotes) { quote in
                Text(quote.text)
            }
            
        }
        .navigationTitle(categoryName)
        .task {
            fetchCategoryQuotes()
        }
    }
    
    //MARK: - API
    private func getCategoryQuotesFromAPI() async throws -> [Quote] {
        guard let url = URL(string: url+categoryName) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Quote].self, from: data)
        return result
    }
    
    private func fetchCategoryQuotes() {
        Task {
            do {
                self.quotes = try await getCategoryQuotesFromAPI()
            } catch {
                print(error)
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        CategoryDetailView(categoryName: "life")
    }
}
