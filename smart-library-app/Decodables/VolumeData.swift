//
//  VolumeData.swift
//  Leafing
//
//  Created by Emma Painter on 8/05/21.
//

import UIKit

class VolumeData: NSObject, Decodable {
    var books: [BookData]?
    
    private enum CodingKeys: String, CodingKey {
        case books = "items"
    }
}
