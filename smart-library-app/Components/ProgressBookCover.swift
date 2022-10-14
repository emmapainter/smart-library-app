//
//  ProgressBookCover.swift
//  smart-library-app
//
//  Created by Emma Painter on 13/10/2022.
//

import SwiftUI

struct ProgressBookCover: View {
//    var readingBook: ReadingBook
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                //            AsyncImage(
                //                url: readingBook.book.getImageUrl(size: .large),
                //                content: { image in
                //                    image.resizable()
                //                        .aspectRatio(contentMode: .fit)
                //                        .frame(height: 300)
                //                        .cornerRadius(10)
                //                },
                //                placeholder: {
                //                    ProgressView()
                //                })
                Rectangle()     // TODO: EP - use cover
                    .fill(.gray)
                    .cornerRadius(10)
                VStack {
                    Spacer()
                    HStack {
                        progressBar
                        Text("70%")
                            .foregroundColor(Color.white)     // TODO: EP - use actual progress
                    }
                    
                    .frame(height: metrics.size.height * 0.07)
                    .padding(.bottom, metrics.size.height * 0.1)
                }
                .padding(.horizontal, 16)
            }
        }
            
    }
    
    var progressBar: some View {
        GeometryReader { metrics in
            ZStack {
                Capsule()
                    .stroke(Color.white, lineWidth: 1)
                HStack {
                    Capsule()
                        .fill(Color.white)
                        .frame(width: metrics.size.width * 0.7)    // TODO: EP - use actual progress
                    Spacer()
                }
            }
        }
        
    }
}

struct ProgressBookCover_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBookCover()
    }
}
