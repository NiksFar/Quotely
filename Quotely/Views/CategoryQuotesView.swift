//
//  CategoryQuotesView.swift
//  Quotely
//
//  Created by Mykyta on 01.09.26.
//

import SwiftUI

struct CategoryQuotesView: View {
    
    let categoryQuote: String
    
    var body: some View {
        Text("\(categoryQuote)")
    }
}

#Preview {
    CategoryQuotesView(categoryQuote: "life")
}
