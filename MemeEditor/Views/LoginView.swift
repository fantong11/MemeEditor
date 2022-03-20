//
//  LoginView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/19.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Meme Editor")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                
                Group {
                    switch viewModel.viewState {
                    case .login:
                        TextFieldWithUnderLine("帳號", text: $viewModel.email, keyboardType: .emailAddress)
                        SecureInputView("密碼", text: $viewModel.password)
                        
                    case .signin:
                        TextFieldWithUnderLine("Email", text: $viewModel.email, keyboardType: .emailAddress)
                        SecureInputView("密碼", text: $viewModel.password)
                        SecureInputView("重新輸入密碼", text: $viewModel.checkPassword)
                        
                    case .resetPassword:
                        TextFieldWithUnderLine("Email", text: $viewModel.email, keyboardType: .emailAddress)
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
                        Text("取得驗證信")
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
                                viewModel.viewState = .resetPassword
                            }
                            .foregroundColor(Color("BlueGreen"))
                            Spacer()
                        }
                    }
                    
                    Button {
                        if viewModel.viewState == .signin || viewModel.viewState == .resetPassword {
                            viewModel.viewState = .login
                        }
                        else {
                            viewModel.viewState = .signin
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
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "multiply")
                    }

                }
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewInterfaceOrientation(.portrait)
    }
}
