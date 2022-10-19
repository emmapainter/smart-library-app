//
//  LibraryView.swift
//  smart-library-app
//
//  Created by Emma Painter on 18/10/2022.
//

import SwiftUI

struct LibraryView: View {
    var allBooks: [BookEdition]?
    var readBooks: [BookEdition]?
    var notReadBooks: [BookEdition]?
    var currentBooks: [ReadingBook]?
    @State var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                NowReading(rootNavigationPath: $navigationPath)
                if let books = allBooks {
                    Text("All")
                    BookCarousel(books: books)
                }
                if let books = readBooks {
                    Text("Read")
                    BookCarousel(books: books)
                }
                if let books = notReadBooks {
                    Text("Unread")
                    BookCarousel(books: books)
                }
                Spacer()
            }
            .padding(16)
            .navigationTitle("Library")
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
