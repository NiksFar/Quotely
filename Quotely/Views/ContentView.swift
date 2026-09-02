//
//  ContentView.swift
//  Quotely
//
//  Created by Mykyta on 01.09.26.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab("Zitat", systemImage: "quote.closing") {
                QuoteView()
            }
            Tab("Autor:innen", systemImage: "person.crop.artframe") {
                AuthorListView()
            }
            Tab("Kategorien", systemImage: "square.grid.2x2.fill") {
                CategoryView()
            }
            Tab("Inspiration", systemImage: "sharedwithyou") {
                InspirationView()
            }
        }
    }
}

#Preview {
    ContentView()
}
