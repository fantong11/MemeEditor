//
//  HistoryView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/4/16.
//

import SwiftUI
import FirebaseAuth

struct UserView: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack {
            HStack {
                
                if let user = viewModel.currentUser {
                    Text(user.email!)
                    Button {
                        viewModel.signOut()
                    } label: {
                        Text("登出")
                    }
                }
                else {
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
                
            }
            .padding()
            Spacer()
        }
        .sheet(isPresented: $viewModel.showLoginView) {
            switch viewModel.signInOrSignUp {
            case .signIn:
                LoginView(viewModel: .init(initialState: LoginViewState(viewState: .signIn), isPresented: $viewModel.showLoginView))
            case .signUp:
                LoginView(viewModel: .init(initialState: LoginViewState(viewState: .signUp), isPresented: $viewModel.showLoginView))
            }
            
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(viewModel: UserViewModel())
    }
}
