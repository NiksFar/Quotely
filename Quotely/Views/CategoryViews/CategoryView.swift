//
//  CategoryView.swift
//  Quotely
//
//  Created by Mykyta on 31.08.26.
//

import SwiftUI

struct CategoryView: View {
    
    @State private var categories: [String] = []
    @State private var showErrorAlert: Bool = false
    @State private var hasError: Bool = false
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationStack {
            VStack {
                LazyVGrid(columns: columns, spacing: 12) {
                    
                    ForEach(categories, id: \.self) { category in
                        
                        NavigationLink {
                            CategoryDetailView(categoryName: category)
                        } label: {
                            Text(translationToDE(category: category))
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
                
                if hasError {
                    Button {
                        hasError = false
                        showErrorAlert = false
                        fetchCategories()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                            .background(.blue)
                            .clipShape(Circle())
                    }
                    .offset(y: -100)
                }
            }
        }
        .task {
            fetchCategories()
        }
        
        .alert("Fehler", isPresented: $showErrorAlert) {
            Button("Ok") { }
        } message: {
            Text("Kategorien konnten leider nicht geladen werden. Bitte versuche es später erneut.")
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
                hasError = true
                showErrorAlert = true
            }
        }
    }
    
    private func translationToDE(category: String) -> String {
        switch category {
        case "motivation":
            return "Motivation"
        case "life":
            return "Leben"
        case "love":
            return "Liebe"
        case "wisdom":
            return "Weisheit"
        case "success":
            return "Erfolg"
        case "happiness":
            return "Glück"
        case "courage":
            return "Mut"
        case "friendship":
            return "Freundschaft"
        case "education":
            return "Bildung"
        case "future":
            return "Zukunft"
        default:
            return category
        }
    }
}

#Preview {
    CategoryView()
}
