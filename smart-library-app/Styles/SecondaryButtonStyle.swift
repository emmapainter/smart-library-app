//
//  SecondaryButton.swift
//  smart-library-app
//
//  Created by Emma Painter on 4/10/2022.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(Color.accentColor)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
    }
}
