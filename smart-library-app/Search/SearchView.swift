//
//  SearchView.swift
//  smart-library-app
//
//  Created by Emma Painter on 30/9/2022.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchType = "All Books"
    @State var bookSearchResults = [Book]()
    
    let searchTypes = ["All Books"]
    let libraryAPI = SmartLibraryAPI()
    
    func search(for text:  String) {
        switch searchType {
        case "All Books":
            Task {
                do {
                    bookSearchResults = try await libraryAPI.searchBooks(searchQuery: text)
                } catch let error {
                    print(error)
                }
                
            }
            break
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
                    NavigationLink(destination: SelectedBookView(id: book.mainEdition)) {
                        BookListItem(book: book)
                    }
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
