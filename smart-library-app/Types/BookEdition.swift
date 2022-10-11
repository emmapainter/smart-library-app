//
//  BookEdition.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/8/22.
//

import Foundation

struct BookEdition: Hashable, Identifiable {
    private let uuid = UUID()
    let id: String
    let title: String
    let description: String?
    let coverId: Int?
    let authorIds: [String]?
    let publishedDate: String?
    let isbn13: String?
    let pages: Int?
    
    func getImageUrl(size: ImageSize) -> URL? {
        guard let imageId = self.coverId else {
            return nil
        }
        
        return Utils().getImageUrl(imageId: imageId, size: size)
    }
}
