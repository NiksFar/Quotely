//
//  Author.swift
//  Quotely
//
//  Created by Mykyta on 02.09.26.
//

import Foundation

struct Author: Codable, Identifiable {
    let id: String
    let name: String
    let slug: String
}
