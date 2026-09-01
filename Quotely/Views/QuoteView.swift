//
//  QuoteView.swift
//  Quotely
//
//  Created by Mykyta on 31.08.26.
//

import SwiftUI

struct QuoteView: View {
    
    @State private var quote: Quote? = nil
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            Image(systemName: "quote.opening")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(.syntaxPurple)
                .padding()
            
            if let quote {
                Text(quote.text)
                    .multilineTextAlignment(.center)
                    .font(.title3.weight(.semibold))
                Text(quote.author)
                    .italic()
                    .foregroundStyle(.primary)
                    .font(.system(size: 18))
            } else {
                Text("The only way to do great work is to love what you do...")
                    .multilineTextAlignment(.center)
                    .font(.title3.weight(.semibold))
                
                Text("No author")
                    .italic()
                    .foregroundStyle(.primary)
                    .font(.system(size: 18))
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 35))
        .shadow(color: .black.opacity(0.15), radius: 10)
        .padding()
        
        .task {
            fetchQuote()
        }
        
        Button {
               fetchQuote()
            //
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "arrow.clockwise")
                Text("Neues Zitat")
            }
            .foregroundStyle(.black)
            .padding(.horizontal, 25)
            .padding(.vertical, 15)
            .background(.syntaxYellow)
            .clipShape(Capsule())
        }
        .padding()
        
    }
    //MARK: -API-Calls
    
    private func getQuoteFromAPI() async throws -> Quote? {
        guard let url = URL(string: "https://api.syntax-institut.de/quotes") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Quote].self, from: data)
        
        return result.first
    }
    
    private func fetchQuote() {
        Task {
            do {
                self.quote = try await getQuoteFromAPI()
            } catch {
                print(error)
            }
        }
    }
    //
    
}

#Preview {
    QuoteView()
}
