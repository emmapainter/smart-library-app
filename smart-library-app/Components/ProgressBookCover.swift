//
//  ProgressBookCover.swift
//  smart-library-app
//
//  Created by Emma Painter on 13/10/2022.
//

import SwiftUI

struct ProgressBookCover: View {
    var readingBook: ReadingBook
    @State var progress: CGFloat = 0
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                AsyncImage(
                    url: readingBook.book.getImageUrl(size: .large),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black]), startPoint: .top, endPoint: .bottom))
                VStack {
                    Spacer()
                    HStack {
                        ProgressView(value: progress)
                            .progressViewStyle(ReadingProgressViewStyle())
                            .frame(width: metrics.size.width * 0.65)
                        Spacer()
                        Text(String(Int(round(progress*100))) + "%")
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            .font(.system(size: 1000))
                            .scaledToFit()
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                    }
                    
                    .frame(height: metrics.size.height * 0.045)
                    .padding(.bottom, metrics.size.height * 0.05)
                }
                .padding(.horizontal, metrics.size.height * 0.04)
            }
            .cornerRadius(10)
        }
        .onAppear {
            if let totalPages = readingBook.book.pages {
                progress = CGFloat(readingBook.bookmark.currentPageNumber) / CGFloat(totalPages)
            }
        }
    }
}

