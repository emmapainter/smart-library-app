//
//  NowReadingView.swift
//  smart-library-app
//
//  Created by Emma Painter on 6/10/2022.
//

import SwiftUI
import CodeScanner

struct NowReading: View {
    @State var isShowingSheet = false
    @Binding var rootNavigationPath: NavigationPath
    @StateObject var viewModel = NowReadingViewModel()
   
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
                isShowingSheet = true
            } label: {
                HStack {
                    Text("Start a new book")
                    Image(systemName: "plus")
                }
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .sheet(isPresented: $isShowingSheet) {
            StartReadingChooseBookView(isShowingSheet: $isShowingSheet, rootNavigationPath: $rootNavigationPath)
        }
        .onAppear(perform: {
            viewModel.getBooks()
        })
    }
    
    
}
