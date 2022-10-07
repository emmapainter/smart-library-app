//
//  PrimaryButtonStyle.swift
//  smart-library-app
//
//  Created by Emma Painter on 7/10/2022.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(Color.white)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(20)
    }
}
