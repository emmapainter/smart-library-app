//
//  ReadingDataCell.swift
//  smart-library-app
//
//  Created by Emma Painter on 17/10/2022.
//

import SwiftUI

struct ReadingDataCell: View {
    var title: String
    var value: String
    var units: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .foregroundColor(Color.accentColor)
                HStack(alignment: .lastTextBaseline) {
                    Text(value)
                        .font(.title)
                        .fontWeight(.medium)
                    Text(units)
                        .fontWeight(.light)
                        .foregroundColor(Color.gray)
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct ReadingDataCell_Previews: PreviewProvider {
    static var previews: some View {
        ReadingDataCell(title: "Reading rate", value: "20", units: "Pages per hour")
            .background(Color.red)
    }
}
