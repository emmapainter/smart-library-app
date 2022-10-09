//
//  BookListItem.swift
//  smart-library-app
//
//  Created by Emma Painter on 2/10/2022.
//

import SwiftUI

struct BookListItem: View {
    let bookApi = BookApi()
    var book: Book

    var body: some View {
        HStack {
            AsyncImage(
                url: book.getImageUrl(size: .medium),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 90)
            },
            placeholder: {
                ProgressView()
            })
                .frame(width: 60, height: 90)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .padding(/*@START_MENU_TOKEN@*/.all, 4.0/*@END_MENU_TOKEN@*/)
                Text(book.authors?.first ?? "-")
                    .font(.body)
                    .foregroundColor(Color.gray)
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .padding([.leading, .bottom, .trailing], 4.0)
                    
                    
            }
            
            
        }
    }
}
