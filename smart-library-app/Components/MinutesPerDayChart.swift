//
//  MinutesPerDayChart.swift
//  smart-library-app
//
//  Created by Emma Painter on 17/10/2022.
//

import SwiftUI
import Charts

struct MinutesPerDayChart: View {
    var readingSessions: [ReadingSession]
    
    var body: some View {
        VStack {
            if (readingSessions.count == 0) {
                Text("Your reading stats will display once you start reading")
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
            } else {
                Chart {
                    ForEach(readingSessions) { session in
                        BarMark(
                            x: .value("Day", session.startTime, unit: .day),
                            y: .value("Minutes", session.getTimeReading() ?? 0)
                        )
                    }
                }
                .frame(height: 250)
                .padding()
            }
        }
    }
}

struct MinutesPerDayChart_Previews: PreviewProvider {
    static var previews: some View {
        MinutesPerDayChart(
            readingSessions: [
                ReadingSession(startTime: DateFormat().formatter.date(from: "10/08/2022 10:00")!, endTime: DateFormat().formatter.date(from: "10/08/2022 10:30"), numberOfPages: 20, bookISBN13: "9781786892720", bookmarkId: "1"),
                ReadingSession(startTime: DateFormat().formatter.date(from: "11/08/2022 16:07")!, endTime: DateFormat().formatter.date(from: "11/08/2022 16:15"), numberOfPages: 5, bookISBN13: "9781786892720", bookmarkId: "1"),
                ReadingSession(startTime: DateFormat().formatter.date(from: "12/08/2022 10:00")!, endTime: DateFormat().formatter.date(from: "12/08/2022 10:17"), numberOfPages: 16, bookISBN13: "9781786892720", bookmarkId: "1"),
                ReadingSession(startTime: DateFormat().formatter.date(from: "13/08/2022 10:00")!, endTime: DateFormat().formatter.date(from: "13/08/2022 10:38"), numberOfPages: 3, bookISBN13: "9781786892720", bookmarkId: "1"),
                ReadingSession(startTime: DateFormat().formatter.date(from: "14/08/2022 10:00")!, endTime: DateFormat().formatter.date(from: "14/08/2022 10:50"), numberOfPages: 27, bookISBN13: "9781786892720", bookmarkId: "1"),
                ReadingSession(startTime: DateFormat().formatter.date(from: "15/08/2022 10:00")!, endTime: DateFormat().formatter.date(from: "15/08/2022 10:20"), numberOfPages: 31, bookISBN13: "9781786892720", bookmarkId: "1"),
                ReadingSession(startTime: DateFormat().formatter.date(from: "17/08/2022 10:00")!, endTime: DateFormat().formatter.date(from: "17/08/2022 11:58"), numberOfPages: 7, bookISBN13: "9781786892720", bookmarkId: "1")
            ]
        )
    }
}
