//
//  BookCarousel.swift
//  smart-library-app
//
//  Created by Emma Painter on 18/10/2022.
//

import SwiftUI

struct BookCarousel: View {
    var books: [BookEdition]
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(books) { book in
                    VStack {
                        AsyncImage(
                            url: book.getImageUrl(size: .large),
                            content: { image in
                                image.resizable()
                                    .frame(width: 150, height: 240)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(10)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                        Text(book.title)
                    }
                }
            }
        }
    }
}

struct BookCarousel_Previews: PreviewProvider {
    static var previews: some View {
        BookCarousel(books: [BookEdition]())
    }
}
