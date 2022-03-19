//
//  ViewExtension.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/20.
//

import Foundation
import SwiftUI

extension View {
   @ViewBuilder
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}
