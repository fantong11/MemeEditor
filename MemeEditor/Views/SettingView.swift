//
//  SettingView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/4/14.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        LoginView(viewModel: .init(initialState: LoginViewState()))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
