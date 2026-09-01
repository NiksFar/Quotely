//
//  CategoryView.swift
//  Quotely
//
//  Created by Mykyta on 31.08.26.
//

import SwiftUI

struct CategoryView: View {
    
    @State private var categories: [String] = []
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationStack {
            
            LazyVGrid(columns: columns, spacing: 12) {
                
                ForEach(categories, id: \.self) { category in
                    
                    NavigationLink {
                        CategoryDetailView(categoryName: category)
                    } label: {
                        Text(category)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(.syntaxYellow)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .contentShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                }
                
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("Kategorien")
        }
        .task {
            fetchCategories()
        }
    }
    //MARK: - API
    private func getCategoriesFromAPI() async throws -> [String] {
        guard let url = URL(string: "https://api.syntax-institut.de/categories") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([String].self, from: data)
        
        return result
    }
    
    private func fetchCategories() {
        Task {
            do {
                self.categories = try await getCategoriesFromAPI()
            } catch {
                print(error)
            }
        }
    }
    
    
}

#Preview {
    CategoryView()
}
