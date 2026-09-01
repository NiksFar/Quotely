//
//  CategoryDetailView.swift
//  Quotely
//
//  Created by Mykyta on 01.09.26.
//

import SwiftUI

struct CategoryDetailView: View {
    
    let categoryQuote: String
    
    let quotes = [
        "life",
        "love",
        "work",
        "food",
        "travel"
    ]
    
    var body: some View {
        
        List {
            ForEach(quotes, id: \.self) {
                Text($0)
            }
            
        }
        .navigationTitle(categoryQuote)
    }
}

#Preview {
    NavigationStack {
        CategoryDetailView(categoryQuote: "life")
    }
}
