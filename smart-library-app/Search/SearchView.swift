//
//  SearchView.swift
//  smart-library-app
//
//  Created by Emma Painter on 30/9/2022.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchType = "My Books"
    @State var bookSearchResults = [BookData]()
    
    let searchTypes = ["My Books", "All Books", "Users"]
    let bookDatabase = BookDatabase()
    
    func searchAllBooks(for text:  String) {
        bookSearchResults = []
        bookDatabase.searchAllBooksFor(text: text, completion: {(books) -> Void in
            bookSearchResults.append(contentsOf: books)
        })
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Pick your search type", selection: $searchType) {
                    ForEach(searchTypes, id: \.self) {type in
                        Text(type)
                            .tag(type)
                    }
                }
                .padding(.horizontal)
                .pickerStyle(SegmentedPickerStyle())
                List(bookSearchResults) { book in
                    BookListItem(book: book)
                }
                .searchable(text: $searchText)
                .onSubmit(of: .search) {
                    searchAllBooks(for: searchText)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
