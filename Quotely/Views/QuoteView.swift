//
//  QuoteView.swift
//  Quotely
//
//  Created by Mykyta on 31.08.26.
//

import SwiftUI

struct QuoteView: View {
    var body: some View {
        
        VStack(spacing: 15) {
            
            Image(systemName: "quote.opening")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(.syntaxPurple)
                .padding()
            
            Text("The only way to do great work is to love what you do...")
                .multilineTextAlignment(.center)
                .font(.title3.weight(.semibold))
               
            
            Text("No author")
                .italic()
                .foregroundStyle(.primary)
                .font(.system(size: 18))
                
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 35))
        .shadow(color: .black.opacity(0.15), radius: 10)
        .padding()
        
        
        Button {
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
}

#Preview {
    QuoteView()
}
