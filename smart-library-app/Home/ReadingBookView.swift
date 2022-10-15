//
//  StartReadingSuccessView.swift
//  smart-library-app
//
//  Created by Emma Painter on 12/10/2022.
//

import SwiftUI

struct ReadingBookView: View {
    var bookmarkBtId: String
    @StateObject var viewModel = ReadingBookViewModel()
    
    var body: some View {
        VStack {
            if let book = viewModel.book {
                ProgressBookCover(readingBook: book)
                Text(book.book.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Text("-")   // TODO: get authors
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.top, 3.0)
                HStack {
                    Button("Update page") {
                        print("Update page") // TODO: EP - update page
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    Button("Finish") {
                        print("Finish") // TODO: EP - finish
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }
                Rectangle()
                    .fill(.gray)
                    .frame(height: 1)
                    .padding(.vertical)
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.getBook(bookmarkBtId: bookmarkBtId)
                    }
            }
        }
        .padding(16)
    }
}

struct StartReadingSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingBookView(bookmarkBtId: "1234")
    }
}
