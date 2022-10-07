//
//  NowReadingView.swift
//  smart-library-app
//
//  Created by Emma Painter on 6/10/2022.
//

import SwiftUI
import CodeScanner

struct NowReading: View {
    @State var currentBooks = [ReadingBook]()
    @State private var isShowingStartReading = false
    
    let bookDatabase = BookDatabase()

    var body: some View {
        VStack {
            HStack {
                Text("Now Reading")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top, 36.0)
            Button {
                isShowingStartReading = true
            } label: {
                HStack {
                    Text("Start a new book")
                    Image(systemName: "plus")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .sheet(isPresented: $isShowingStartReading) {
            StartReadingChooseBookView()
        }
    }
    
    
}

struct NowReadingView_Previews: PreviewProvider {
    static var previews: some View {
        NowReading()
    }
}
