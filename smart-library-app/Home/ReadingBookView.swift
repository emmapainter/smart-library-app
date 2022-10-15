//
//  StartReadingSuccessView.swift
//  smart-library-app
//
//  Created by Emma Painter on 12/10/2022.
//

import SwiftUI

struct ReadingBookView: View {
    var bookmarkBtId: String?
    var book: ReadingBook?
    @StateObject var viewModel = ReadingBookViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                if let book = viewModel.book {
                    ProgressBookCover(readingBook: book)
                        .frame(height: 450)
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
                            if let bookmarkBtId = bookmarkBtId {
                                viewModel.getBook(bookmarkBtId: bookmarkBtId)
                            } else {
                                viewModel.book = book
                            }
                        }
                }
            }
            .padding(16)
            .toolbar {
                Button {
                    print("sheet") // TODO: EP - open action sheet
                } label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .foregroundStyle(Color.accentColor, .gray)
                }
                
            }
        }
    }
}

struct StartReadingSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingBookView(bookmarkBtId: "1234")
    }
}
