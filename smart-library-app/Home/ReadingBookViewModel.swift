//
//  ReadingBookViewModel.swift
//  smart-library-app
//
//  Created by Emma Painter on 12/10/2022.
//

import Foundation
import UIKit

class ReadingBookViewModel: NSObject, ObservableObject {
    @Published var book: ReadingBook?
}
