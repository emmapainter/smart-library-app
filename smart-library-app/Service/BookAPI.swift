//
//  BookApi.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/8/22.
//

import Foundation

private let API_BASE = "openlibrary.org"
private let SECONDARY_API_BASE = "www.googleapis.com"

class BookAPI: BookAPIProtocol {
    func getBookEdition(id: String) async throws -> BookEdition {
        let result = try await getApiResponse(endpoint: "/book/\(id).json", queryItems: nil, type: BookEditionData.self)
        var book = BookEdition.init(result)
        if let isbn13 = book.isbn13, book.pages == nil {
            book.pages = try await getNumberOfPages(isbn13: isbn13)
        }
        return book
    }
    
    func getBookEdition(isbn13: String) async throws -> BookEdition {
        let result = try await getApiResponse(endpoint: "/isbn/\(isbn13).json", queryItems: nil, type: BookEditionData.self)
        var book = BookEdition.init(result)
        if book.pages == nil {
            book.pages = try await getNumberOfPages(isbn13: isbn13)
        }
        return book
    }
    
    func getBookAuthors(authorIds: [String]) async throws -> [Author] {
        var authors = [Author]()

        for id in authorIds {
            let author = try await getApiResponse(endpoint: "\(id).json", queryItems: nil, type: Author.self)
            authors.append(author)
        }
        
        return authors
    }
    
    func getNumberOfPages(isbn13: String) async throws -> Int? {
        let queryItems = [URLQueryItem(name: "q", value: "isbn13:\(isbn13)")]
        let result = try await getApiResponse(endpoint: "/books/v1/volumes", queryItems: queryItems, type: GoogleVolume.self, secondaryAPI: true)
        return result.books?[0].pages
    }
    
    func getBookCover(isbn13: String) async throws -> String? {
        let result = try await getApiResponse(endpoint: "/books/v1/volumes?q=isbn:\(isbn13)", queryItems: nil, type: GoogleVolume.self)
        return result.books?[0].imageURL
    }
    
    func searchBooks(searchQuery: String) async throws -> [Book] {
        let queryItems = [URLQueryItem(name: "q", value: searchQuery)]
        let results = try await getApiResponse(endpoint: "/search.json", queryItems: queryItems, type: BookSearchResult.self)
        let books = results.books.filter {$0.mainEdition != nil}
        
        return books
    }
    
    private func getUrlRequest(endpoint: String, queryItems: [URLQueryItem]?, secondaryAPI: Bool) -> URLRequest {
        
        // RK: The mock data passed in from the scanning library adds this character to the start, so I'm removing it here
        let endpoint = endpoint.replacingOccurrences(of: "\u{200E}", with: "")
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = secondaryAPI ? SECONDARY_API_BASE : API_BASE
        urlComponents.path =  endpoint
        urlComponents.queryItems = queryItems

        
        guard let requestUrl = urlComponents.url else {
            fatalError("invalid url") // should throw!!!
        }
        
        return URLRequest(url: requestUrl)
    }
    
    private func getApiResponse<T>(endpoint: String, queryItems: [URLQueryItem]?, type: T.Type, secondaryAPI: Bool = false) async throws -> T where T: Decodable {
        let urlRequest = getUrlRequest(endpoint: endpoint, queryItems: queryItems, secondaryAPI: secondaryAPI)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()
        
        return try decoder.decode(type, from: data)
    }
}

// MARK: - Codable helpers
private extension BookEdition {
    init(_ data: BookEditionData) {
        self.init(
            id: data.key,
            title: data.title ?? "",
            description: data.description,
            coverId: data.covers?.first,
            authorIds: data.authors?.map {$0.key},
            publishedDate: data.publish_date,
            isbn13: data.isbn_13?.first,
            pages: data.number_of_pages
        )
    }
}

// MARK: - Codables
private struct BookSearchResult: Codable {
    let start: Int
    let total: Int
    let books: [Book]
    
    private enum CodingKeys: String, CodingKey {
        case start
        case total = "num_found"
        case books = "docs"
    }
}

private struct AuthorKeys: Codable {
    let key: String
}

private struct BookEditionData: Codable {
    let key: String
    let title: String?
    let description: String?
    let covers: [Int]?
    let by_statement: String?
    let authors: [AuthorKeys]?
    let publish_date: String?
    let isbn_13: [String]?
    let number_of_pages: Int?
}



