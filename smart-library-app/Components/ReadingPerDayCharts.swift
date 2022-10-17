//
//  ReadingPerDayCharts.swift
//  smart-library-app
//
//  Created by Emma Painter on 17/10/2022.
//

import SwiftUI

struct ReadingPerDayCharts: View {
    @State private var chartType = "Pages"
    let chartTypes = ["Pages", "Minutes"]
    var readingSessions: [ReadingSession]
    
    var body: some View {
        VStack {
            Text("Reading Per Day")
            Picker("Pick your chart type", selection: $chartType) {
                ForEach(chartTypes, id: \.self) {type in
                    Text(type)
                        .tag(type)
                }
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())
            if chartType == "Pages" {
                PagesPerDayChart(readingSessions: readingSessions)
            } else {
                MinutesPerDayChart(readingSessions: readingSessions)
            }
        }
        
    }
}

struct ReadingPerDayCharts_Previews: PreviewProvider {
    static var previews: some View {
        ReadingPerDayCharts(
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
