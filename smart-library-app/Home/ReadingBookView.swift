//
//  StartReadingSuccessView.swift
//  smart-library-app
//
//  Created by Emma Painter on 12/10/2022.
//

import SwiftUI

struct ReadingBookView: View {
    var book: ReadingBook
    @EnvironmentObject private var user: User
    @State var authors = "-"
    
    var body: some View {
        ZStack(alignment: .center) {
            if let book = user.readingBooks.first(where: {$0 == book})
                {
                ScrollView {
                    VStack {
                        VStack {
                            ProgressBookCover(readingBook: book)
                                .frame(height: 450)
                            Text(book.book.title)
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .padding(.top)
                            Text(authors)   // TODO: get authors
                                .font(.title2)
                                .multilineTextAlignment(.center)
                                .padding(.top, 3.0)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        ReadingPerDayCharts(readingSessions: book.sessions)
                        ReadingDataCell(title: "Reading rate", value: String(book.getPagesPerHour()), units: "pages per hour")
                        ReadingDataCell(title: "Daily reading average", value: String(book.getAverageMinutesPerDay()), units: "minutes per day")
                        ReadingDataCell(title: "Daily reading average", value: String(book.getPagesPerDay()), units: "pages per day")
                        ReadingDataCell(title: "Session reading average", value: String(book.getAveragePagesPerSession()), units: "pages per session")
                        ReadingDataCell(title: "Session reading average", value: String(book.getAverageMinutesPerSession()), units: "minutes per session")
                        ReadingDataCell(title: "Total time reading", value: String(book.getTotalMinutesReading()), units: "minutes")
                        ReadingDataCell(title: "Total pages read", value: String(book.bookmark.currentPageNumber), units: "pages")
                    }
                    .padding(16)
                }
                .background(Color(red: 242/255, green: 241/255, blue: 246/255))
            } else {
                ProgressView()
            }
        }
        .toolbar {
            Button {
                print("sheet") // TODO: EP - open action sheet
            } label: {
                Image(systemName: "ellipsis.circle.fill")
                    .foregroundStyle(Color.accentColor, Color.init(red: 238/255, green: 238/255, blue: 240/255, opacity: 1))
            }
            
        }
        .onAppear(perform: {
            getAuthors()
        })
    }
    
    func getAuthors() {
        Task {
            guard let authorIds = book.book.authorIds else {
                return
            }
            do {
                let libraryAPI = SmartLibraryAPI()
                let authorsArray = try await libraryAPI.getBookAuthors(authorIds: authorIds)
                authors = authorsArray.map {$0.name}.joined(separator: ", ")
                print(authors)
            } catch {
                // Authors will just stay as "-"
            }
        }
    }

    
}


//struct StartReadingSuccessView_Previews: PreviewProvider {
//    static var previews: some View {
////        ReadingBookView(book: ReadingBook(book: <#T##BookEdition#>, bookmark: <#T##Bookmark#>))
//    }
//}
