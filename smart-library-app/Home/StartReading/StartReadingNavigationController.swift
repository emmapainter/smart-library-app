//
//  StartReadingNavigationDelegate.swift
//  smart-library-app
//
//  Created by Emma Painter on 12/10/2022.
//

import Foundation
import SwiftUI

class StartReadingNavigationController: ObservableObject {
    @Published var rootNavigationPath = NavigationPath()
    @Published var isShowingSheet = false
}
