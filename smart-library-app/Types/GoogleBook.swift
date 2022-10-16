//
//  GoogleBook.swift
//  smart-library-app
//
//  Created by Emma Painter on 16/10/2022.
//

import Foundation

struct GoogleVolume: Decodable {
    var books: [GoogleBook]?
    
    private enum CodingKeys: String, CodingKey {
        case books = "items"
    }
}
class GoogleBook: Codable {
    var bookId: String?
    var pages: Int?
    var imageURL: String?
    
    required init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootKeys.self)
        let bookContainer = try rootContainer.nestedContainer(keyedBy: BookKeys.self, forKey: .volumeInfo)
        let imageContainer = try? bookContainer.nestedContainer(keyedBy: ImageKeys.self, forKey: .imageLinks)
        imageURL = try imageContainer?.decode(String.self, forKey: .thumbnail)
        pages = try? bookContainer.decode(Int.self, forKey: .pages)
    }
    
    private enum RootKeys: String, CodingKey {
        case volumeInfo
        case bookId = "id"
    }
    
    private enum BookKeys: String, CodingKey {
        case pages = "pageCount"
        case imageLinks
    }
    
    private enum ImageKeys: String, CodingKey {
        case thumbnail
    }
}
