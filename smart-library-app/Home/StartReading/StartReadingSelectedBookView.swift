//
//  StartReadingSelectedBookView.swift
//  smart-library-app
//
//  Created by Emma Painter on 7/10/2022.
//

import SwiftUI

struct StartReadingSelectedBookView: View {
    var isbn: String
    @StateObject var viewModel = StartReadingSelectedBookViewModel()
    
    var body: some View {
        
        if let book = viewModel.book {
            VStack {
                Spacer()
//                AsyncImage(
//                    url: URL(string: book.imageURL?.replacingOccurrences(of: "http", with: "https") ?? ""),
//                    content: { image in
//                        image.resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(height: 300)
//                    },
//                    placeholder: {
//                        ProgressView()
//                    })
                .padding(.bottom)
                        .frame(height: 300)
                Text(book.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Text(book.author ?? "-")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.top, 3.0)
                Spacer()
                Button("Start Reading") {
                    
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding(16)
        } else {
            ProgressView()
                .onAppear() {
                    viewModel.getBook(isbn: isbn)
                }
        }
    }
}

struct StartReadingSelectedBookView_Previews: PreviewProvider {
    static var previews: some View {
        StartReadingSelectedBookView(isbn: "‎9780141037257")
    }
}
