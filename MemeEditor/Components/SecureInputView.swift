//
//  SecureInputView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/20.
//

import SwiftUI

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    @FocusState private var textFieldIsFocused: Bool
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            VStack {
                if isSecured {
                    SecureField(title, text: $text)
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                        .focused($textFieldIsFocused)
                    Divider()
                        .frame(height: 1)
                        .background(textFieldIsFocused == true ? Color("BlueGreen") : .clear)
                        .padding(.horizontal, 30)
                } else {
                    TextField(title, text: $text)
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                        .focused($textFieldIsFocused)
                    Divider()
                        .frame(height: 1)
                        .background(textFieldIsFocused == true ? Color("BlueGreen") : .clear)
                        .padding(.horizontal, 30)
                }
            }
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
            .padding(.horizontal, 30)
            .padding(.top, 10)
            
        }
        
    }
}

struct SecureInputView_Previews: PreviewProvider {
    static var previews: some View {
        SecureInputView("Password", text: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
