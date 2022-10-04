//
//  GoogleBooks.swift
//  smart-library-app
//
//  Created by Emma Painter on 2/10/2022.
//

import UIKit

class BookDatabase: NSObject {
    let REQUEST_STRING = "https://www.googleapis.com/books/v1/volumes?q="
    let MAX_ITEMS_PER_REQUEST = 40
    let MAX_REQUESTS = 10
    var currentRequestIndex: Int = 0
    var terminate = false
    
    func terminateSearch() {
        terminate = true
    }
    
    private func searchGoogleBooksFor(text: String, completion:@escaping([BookData]) -> ()) {
        var searchURLComponents = URLComponents()
        searchURLComponents.scheme = "https"
        searchURLComponents.host = "www.googleapis.com"
        searchURLComponents.path = "/books/v1/volumes"
        searchURLComponents.queryItems = [URLQueryItem(name: "maxResults", value: "\(MAX_ITEMS_PER_REQUEST)"), URLQueryItem(name: "startIndex", value: "\(currentRequestIndex * MAX_ITEMS_PER_REQUEST)"), URLQueryItem(name: "q", value: text)
        ]
        
        guard let requestURL = searchURLComponents.url else {
            print("Invalid URL.")
            return
        }
        
        // create data task and execute it
        URLSession.shared.dataTask(with: requestURL) {
            (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let volumeData = try decoder.decode(VolumeData.self, from: data!)
                
                if let books = volumeData.books {
                    DispatchQueue.main.async {
                        completion(books)
                    }
                    
                    if books.count == self.MAX_ITEMS_PER_REQUEST && self.currentRequestIndex + 1 < self.MAX_REQUESTS && !self.terminate {
                        self.currentRequestIndex += 1
                        self.searchAllBooksFor(text: text, completion: completion)
                    } else {
                        self.currentRequestIndex = 0
                    }
                }
            } catch let err {
                print(err)
            }
        }.resume()
    }
    
    func searchAllBooksFor(text: String, completion:@escaping ([BookData]) -> ()) {
        terminate = false
        searchGoogleBooksFor(text: text, completion: completion)
    }
}
