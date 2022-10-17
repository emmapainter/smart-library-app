//
//  PagesPerDayChart.swift
//  smart-library-app
//
//  Created by Emma Painter on 17/10/2022.
//

import SwiftUI
import Charts

struct PagesPerDayChart: View {
    var readingSessions: [ReadingSession]
    
    var body: some View {
        Chart {
            ForEach(readingSessions) { session in
                BarMark(
                    x: .value("Day", session.startTime, unit: .day),
                    y: .value("Pages", session.numberOfPages ?? 0)
                )
            }
        }
        .frame(height: 250)
        .padding()
    }
}

struct PagesPerDayChart_Previews: PreviewProvider {
    static var previews: some View {
        PagesPerDayChart(
            readingSessions: [
                ReadingSession(startTime: DateFormat().formatter.date(from: "10/08/2022")!, numberOfPages: 20, bookISBN13: "9781786892720", bookmarkId: "1"),
                ReadingSession(startTime: DateFormat().formatter.date(from: "11/08/2022")!, numberOfPages: 5, bookISBN13: "9781786892720", bookmarkId: "1"),
                ReadingSession(startTime: DateFormat().formatter.date(from: "12/08/2022")!, numberOfPages: 16, bookISBN13: "9781786892720", bookmarkId: "1"),
                ReadingSession(startTime: DateFormat().formatter.date(from: "13/08/2022")!, numberOfPages: 3, bookISBN13: "9781786892720", bookmarkId: "1"),
                ReadingSession(startTime: DateFormat().formatter.date(from: "14/08/2022")!, numberOfPages: 27, bookISBN13: "9781786892720", bookmarkId: "1"),
                ReadingSession(startTime: DateFormat().formatter.date(from: "15/08/2022")!, numberOfPages: 31, bookISBN13: "9781786892720", bookmarkId: "1"),
                ReadingSession(startTime: DateFormat().formatter.date(from: "17/08/2022")!, numberOfPages: 7, bookISBN13: "9781786892720", bookmarkId: "1")
            ]
        )
    }
}

struct DateFormat {
    let formatter = DateFormatter()
    
    init() {
        formatter.dateFormat = "dd/MM/yyyy"
    }
}
