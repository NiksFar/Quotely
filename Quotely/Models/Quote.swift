//
//  Quote.swift
//  Quotely
//
//  Created by Mykyta on 31.08.26.
//
import Foundation

struct Quote: Codable {
    let id: String
    let text: String
    let author: String
    let category: String
    let language: String

}
