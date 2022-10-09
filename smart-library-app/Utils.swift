//
//  utils.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/9/22.
//

import Foundation

enum ImageSize: String {
    case small = "S"
    case medium = "M"
    case large = "L"
}

struct Utils {
    func getImageUrl(imageId: Int, size: ImageSize) -> URL? {
        let imageUrl = URL(string: "https://covers.openlibrary.org/b/id/\(imageId)-\(size.rawValue).jpg")
        return imageUrl
    }
}
