//
//  QuoteView.swift
//  Quotely
//
//  Created by Mykyta on 31.08.26.
//

import SwiftUI

struct QuoteView: View {
    
    @State private var quote: Quote? = nil
    @State private var showErrorAlert: Bool = false
    @State private var hasError: Bool = false
    
    private var errorMessage: String = "Das Zitat konnte leider nicht geladen werden. Bitte versuche es später erneut."
    
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                
                Image(systemName: "quote.opening")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(.syntaxPurple)
                    .padding(5)
                
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
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 35))
            .shadow(color: .black.opacity(0.15), radius: 10)
            
            .padding()
            
            .task {
                fetchQuote()
            }
            
            Button {
                hasError = false
                fetchQuote()
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
            
            //Button "Erneut versuchen"
            if hasError {
                Button {
                    hasError = false
                    showErrorAlert = false
                    fetchQuote()
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 40)
                        .background(.blue)
                        .clipShape(Circle())
                }
            }
            //
        }
        .alert("Fehler", isPresented: $showErrorAlert) {
            Button("Ok") { }
        } message: {
            Text(errorMessage)
        }
        
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
                hasError = true
                showErrorAlert = true
            }
        }
    }
    //
    
}

#Preview {
    QuoteView()
}
