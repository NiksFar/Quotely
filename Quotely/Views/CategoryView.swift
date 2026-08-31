//
//  CategoryView.swift
//  Quotely
//
//  Created by Mykyta on 31.08.26.
//

import SwiftUI

struct CategoryView: View {
    
    let categories = [
        "Motivation",
        "Life",
        "Love",
        "Wisdom",
        "Success",
        "Happiness",
        "Courage",
        "Friendship",
        "Education",
        "Future"
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationStack {
            
            LazyVGrid(columns: columns, spacing: 12) {
                
                ForEach(categories, id: \.self) { category in
                    
                    NavigationLink {
                        CategoryQuotesView(categoryQuote: category)
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
    }
}

#Preview {
    CategoryView()
}
