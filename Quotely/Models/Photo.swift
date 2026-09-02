//
//  Photo.swift
//  Quotely
//
//  Created by Mykyta on 03.09.26.
//

import Foundation


struct UnsplashResponse: Codable {
    let results: [Photo]
}

struct Photo: Codable, Identifiable {
    let id: String
    let width: Int
    let height: Int
    let urls: PhotoURLs
}

struct PhotoURLs: Codable {
    let regular: String
}
