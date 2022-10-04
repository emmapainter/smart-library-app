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
    
    func search(for text:  String) {
        bookDatabase.terminateSearch()
        bookSearchResults = []
        switch searchType {
        case searchTypes[0]:
            break
        case searchTypes[1]:
            bookDatabase.searchAllBooksFor(text: text, completion: {(books) -> Void in
                bookSearchResults.append(contentsOf: books)
            })
            break
        case searchTypes[2]: break
        default:
            break
        }
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
                .onChange(of: searchType) { newValue in
                    search(for: searchText)
                }
                .padding(.horizontal)
                .pickerStyle(SegmentedPickerStyle())
                List(bookSearchResults) { book in
                    BookListItem(book: book)
                }
                .searchable(text: $searchText)
                .onSubmit(of: .search) {
                    search(for: searchText)
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
