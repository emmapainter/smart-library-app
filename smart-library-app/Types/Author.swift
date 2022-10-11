//
//  Author.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/9/22.
//

import Foundation

struct Author: Codable, Hashable, Identifiable {
    private let uuid = UUID()
    let id: String
    let name: String
    let photoIds: [Int]?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case id = "key"
        case photoIds = "photos"
    }
}
