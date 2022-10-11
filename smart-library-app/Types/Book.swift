//
//  Book.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/8/22.
//

import Foundation

struct Book: Codable, Hashable, Identifiable {
    private let uuid = UUID()
    let id: String
    let coverId: Int?
    let title: String
    let authors: [String]?
    let authorIds: [String]?
    let publishedDate: Date?
    let mainEdition: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case id = "key"
        case coverId = "cover_i"
        case authors = "author_name"
        case authorIds = "author_key"
        case publishedDate = "first_publish_year"
        case mainEdition = "cover_edition_key"
    }
    
    func getImageUrl(size: ImageSize) -> URL? {
        guard let imageId = self.coverId else {
            return nil
        }
        
        return Utils().getImageUrl(imageId: imageId, size: size)
    }
}
