//
//  BookData.swift
//  FIT3178_W05_Lab
//
//  Created by Emma Painter on 30/03/21.
//  Copyright © 2021 Emma Painter. All rights reserved.
//

import UIKit

class BookData: NSObject, Decodable, Identifiable {
    var id = UUID()
    var isbn13: String?
    var title: String?
    var authors: String?
    var publisher: String?
    var publicationDate: String?
    var bookDescription: String?
    var imageURL: String?
    var genres: [String]?
    var rating: Double?
    var bookId: String?
    
    required init(from decoder: Decoder) throws {
        // get the root container
        let rootContainer = try decoder.container(keyedBy: RootKeys.self)
        
        // get the book container for most info
        let bookContainer = try rootContainer.nestedContainer(keyedBy: BookKeys.self, forKey: .volumeInfo)
        
        // get the image links
        let imageContainer = try? bookContainer.nestedContainer(keyedBy: ImageKeys.self, forKey: .imageLinks)
        
        // get the book info
        title = try? bookContainer.decode(String.self, forKey: .title)
        publisher = try? bookContainer.decode(String.self, forKey: .publisher)
        publicationDate = try? bookContainer.decode(String.self, forKey: .publicationDate)
        bookDescription = try? bookContainer.decode(String.self, forKey: .bookDescription)
        
        // get authors as an array then compact
        if let authorArray = try? bookContainer.decode([String].self, forKey: .authors) {
            authors = authorArray.joined(separator: ", ")
        }
        
        // get genres as an array
        genres = try? bookContainer.decode([String].self, forKey: .genres)
        
        // get IBSN 13
        // First get the ISBNCodes as an array of ISBNCode
        if let isbnCodes = try? bookContainer.decode([ISBNCode].self, forKey: .industryIdentifiers) {
            // loop through array and find the ISBN13
            for code in isbnCodes {
                if code.type == "ISBN_13" {
                    isbn13 = code.identifier
                }
            }
        }
        
        rating = try? bookContainer.decode(Double.self, forKey: .rating)
        
        bookId = try? rootContainer.decode(String.self, forKey: .bookId)
        
        // get the image thumbnail
        imageURL = try imageContainer?.decode(String.self, forKey: .thumbnail)
        
        
    }
    
    private enum RootKeys: String, CodingKey {
        case volumeInfo
        case bookId = "id"
    }

    private enum BookKeys: String, CodingKey {
        case title
        case publisher
        case publicationDate = "publishedDate"
        case bookDescription = "description"
        case authors
        case industryIdentifiers
        case imageLinks
        case genres = "categories"
        case rating = "averageRating"
        
    }

    private enum ImageKeys: String, CodingKey {
        case thumbnail
    }

}

private struct ISBNCode: Decodable {
    var type: String
    var identifier: String
}

