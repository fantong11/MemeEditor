//
//  LoginView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/19.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    @State var account: String = ""
    @State var password: String = ""
    @State var checkPassword: String = ""
    @FocusState var accountTextFieldIsFocused: Bool
    @FocusState var passordTextFieldIsFocused: Bool
    
    var body: some View {
        VStack {
            Text("Meme Editor")
                .fontWeight(.bold)
                .font(.title)
            
            Group {
                TextField(viewModel.viewState == .login ? "帳號" : "Email", text: $account)
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    .focused($accountTextFieldIsFocused)
                
                Divider()
                    .frame(height: 1)
                    .padding(.horizontal, 30)
            }
            
            Group {
                TextField("密碼", text: $password)
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    .focused($passordTextFieldIsFocused)
                
                Divider()
                    .frame(height: 1)
                    .padding(.horizontal, 30)
            }
            
            
            if viewModel.viewState == .signin {
                Group {
                    TextField("重新輸入密碼", text: $checkPassword)
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                        .focused($passordTextFieldIsFocused)
                    
                    Divider()
                        .frame(height: 1)
                        .padding(.horizontal, 30)
                }
            }
            
            Button {
                
            } label: {
                
                switch viewModel.viewState {
                case .login:
                    Text("登入")
                case .signin:
                    Text("註冊帳號")
                case .resetPassword:
                    Text("")
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(10)
            .foregroundColor(.white)
            .background(Color("BlueGreen"))
            .cornerRadius(10)
            .padding()
            
            HStack {
                Spacer()
                
                if viewModel.viewState == .login {
                    Group {
                        Button("忘記密碼") {
                            
                        }
                        .foregroundColor(Color("BlueGreen"))
                        Spacer()
                    }
                }
                
                Button {
                    if viewModel.viewState == .login {
                        viewModel.viewState = .signin
                    }
                    else {
                        viewModel.viewState = .login
                    }
                } label: {
                    if viewModel.viewState == .login {
                        Text("註冊帳號")
                    }
                    else {
                        Text("前往登入")
                    }
                }
                .foregroundColor(Color("BlueGreen"))
                
                Spacer()
            }
            .padding()
            Spacer()
        }
        .animation(.easeIn, value: viewModel.viewState)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
