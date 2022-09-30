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
    let searchTypes = ["My Books", "All Books", "Users"]
    
    func searchAllBooks(for text:  String) {
        print(text)
    }
    
    var body: some View {
        NavigationView {
            Picker("Pick your search type", selection: $searchType) {
                ForEach(searchTypes, id: \.self) {type in
                    Text(type)
                        .tag(type)
                }
            }
            .padding(.horizontal)
            .pickerStyle(SegmentedPickerStyle())
                .searchable(text: $searchText)
                .onSubmit(of: .search) {
                    searchAllBooks(for: searchText)
                }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
