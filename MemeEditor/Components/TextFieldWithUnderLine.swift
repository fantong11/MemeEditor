//
//  TextFieldWithUnderLine.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/20.
//

import SwiftUI

struct TextFieldWithUnderLine: View {
    @Binding private var text: String
    @FocusState private var textFieldIsFocused: Bool
    private var title: String
    private var keyboardType: UIKeyboardType
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
        self.keyboardType = .default
    }
    
    init(_ title: String, text: Binding<String>, keyboardType: UIKeyboardType) {
        self.title = title
        self._text = text
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        VStack {
            TextField(title, text: $text)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(.never)
                .padding(.horizontal, 30)
                .padding(.top, 20)
                .focused($textFieldIsFocused)
            Divider()
                .frame(height: 1)
                .background(textFieldIsFocused == true ? Color("BlueGreen") : .clear)
                .padding(.horizontal, 30)
        }
    }
}

struct TextFieldWithUnderLine_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithUnderLine("Email", text: .constant(""), keyboardType: .emailAddress)
            .previewLayout(.sizeThatFits)
    }
}
