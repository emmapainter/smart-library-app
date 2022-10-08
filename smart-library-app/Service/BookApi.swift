//
//  BookApi.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/8/22.
//

import Foundation

private let API_BASE = "openlibrary.org"
private let IMAGE_BASE = "covers.openlibrary.org/b/id"

class BookApi: BookApiProtocol {
//    func getBookEdition(id: String) async throws -> Book {
//        // do nothing
//    }
//    
//    func getBook(isbn13: String) async throws -> Book {
//        // do nothing
//    }
    
    func searchBooks(searchQuery: String) async throws -> [Book] {
        let queryItems = [URLQueryItem(name: "q", value: searchQuery)]
        let results = try await getApiResponse(endpoint: "/search.json", queryItems: queryItems, type: BookSearchResult.self)
        let books = results.books.filter {$0.mainEdition != nil}
        
        return books
    }
    
    private func getUrlRequest(endpoint: String, queryItems: [URLQueryItem]?) -> URLRequest {
        // Build url components
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = API_BASE
        urlComponents.path =  endpoint
        urlComponents.queryItems = queryItems
        
        guard let requestUrl = urlComponents.url  else {
            fatalError("invalid url") // should throw!!!
        }
        
        return URLRequest(url: requestUrl)
        
    }
    
    private func getApiResponse<T>(endpoint: String, queryItems: [URLQueryItem]?, type: T.Type) async throws -> T where T: Decodable {
        let urlRequest = getUrlRequest(endpoint: endpoint, queryItems: queryItems)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()
        
        return try decoder.decode(type, from: data)
    }
    
    


}

// MARK: - Codable helpers
private extension BookEdition {
    init(_ data: BookEditionData) {
        self.init(
            id: data.id,
            title: data.title,
            description: data.description,
            coverId: data.covers?.first,
            author: data.by_statement,
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
    let id: String
    let key: String
    let title: String
    let description: String?
    let covers: [Int]?
    let by_statement: String?
    let authors: [AuthorKeys]?
    let publish_date: Date?
    let isbn_13: [String]?
    let number_of_pages: Int?
}



