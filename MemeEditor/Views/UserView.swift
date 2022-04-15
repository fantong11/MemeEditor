//
//  HistoryView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/4/16.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    viewModel.showLoginView = true
                    viewModel.signInOrSignUp = .signUp
                } label: {
                    Text("註冊")
                }
                Spacer()
                Button {
                    viewModel.showLoginView = true
                    viewModel.signInOrSignUp = .signIn
                } label: {
                    Text("登入")
                }
                Spacer()
            }
            .padding()
            Spacer()
        }
        .sheet(isPresented: $viewModel.showLoginView) {
            switch viewModel.signInOrSignUp {
            case .signIn:
                LoginView(viewModel: .init(initialState: LoginViewState(viewState: .signIn)))
            case .signUp:
                LoginView(viewModel: .init(initialState: LoginViewState(viewState: .signUp)))
            }
            
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(viewModel: UserViewModel())
    }
}
