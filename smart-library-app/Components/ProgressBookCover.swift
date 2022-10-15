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
    @State var height: CGFloat?
    @State var width: CGFloat?
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                AsyncImage(
                    url: readingBook.book.getImageUrl(size: .large),
                    content: { image in
                        image.resizable()
                            .frame(width: width ?? metrics.size.width, height: height ?? metrics.size.height)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: width ?? metrics.size.width, height: height ?? metrics.size.height)
                    .background(LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black]), startPoint: .top, endPoint: .bottom))
                VStack {
                    Spacer()
                    HStack {
                        ProgressView(value: progress)
                            .progressViewStyle(ReadingProgressViewStyle())
                            .frame(width: (width != nil) ? width! * 0.65 : metrics.size.width * 0.65)
                        Spacer()
                        Text(String(Int(round(progress*100))) + "%")
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            .font(.system(size: 1000))
                            .scaledToFit()
                            .minimumScaleFactor(0.005)
                            .lineLimit(1)
                    }
                    
                    .frame(height: (height != nil) ? height! * 0.045 : metrics.size.height * 0.045)
                    .padding(.bottom, metrics.size.height * 0.05)
                }
                .padding(.horizontal, metrics.size.height * 0.04)
            }
            .frame(width: width ?? metrics.size.width, height: height ?? metrics.size.height)
            .cornerRadius(10)
            .onAppear {
                if metrics.size.height <= metrics.size.width * 1.6 {
                    height = metrics.size.height
                    width = metrics.size.height / 1.6
                } else {
                    height = metrics.size.width * 1.6
                    width = metrics.size.width
                }
            }
        }
        .frame(width: width, height: height)
        .onAppear {
            if let totalPages = readingBook.book.pages {
                progress = CGFloat(readingBook.bookmark.currentPageNumber) / CGFloat(totalPages)
            }
        }
    }
}

