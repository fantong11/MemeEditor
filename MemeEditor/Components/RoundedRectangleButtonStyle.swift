//
//  RoundedRectangleButtonStyle.swift
//  MemeEditor
//
//  Created by Ian Liu on 6/15/22.
//

import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
        configuration.label.font(.headline.bold()).foregroundColor(.white)
      Spacer()
    }
    .padding()
    .background(Color.accentColor.cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

