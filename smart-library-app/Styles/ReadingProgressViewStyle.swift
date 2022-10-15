//
//  ReadingProgressViewStyle.swift
//  smart-library-app
//
//  Created by Emma Painter on 14/10/2022.
//

import Foundation
import SwiftUI

struct ReadingProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return GeometryReader { metrics in
            ZStack {
                Capsule()
                    .stroke(Color.white, lineWidth: 1)
                HStack {
                    Capsule()
                        .fill(Color.white)
                        .frame(width: metrics.size.width * fractionCompleted)    // TODO: EP - use actual progress
                    Spacer()
                }
            }
        }
    }
}
