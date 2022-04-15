//
//  LoginView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/19.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Meme Editor")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                
                Group {
                    switch viewModel.state.viewState {
                    case .signIn:
                        TextFieldWithUnderLine("帳號", text: $viewModel.state.email, keyboardType: .emailAddress)
                        SecureInputView("密碼", text: $viewModel.state.password)
                        
                    case .signUp:
                        TextFieldWithUnderLine("Email", text: $viewModel.state.email, keyboardType: .emailAddress)
                        SecureInputView("密碼", text: $viewModel.state.password)
                        SecureInputView("重新輸入密碼", text: $viewModel.state.comfirmPassword)
                        
                    case .resetPassword:
                        TextFieldWithUnderLine("Email", text: $viewModel.state.email, keyboardType: .emailAddress)
                    }
                }
                
                Button {
                    switch viewModel.state.viewState {
                    case .signIn:
                        viewModel.signIn()
                    case .signUp:
                        viewModel.signUp()
                    case .resetPassword:
                        viewModel.resetPassword()
                    }
                    
                } label: {
                    
                    switch viewModel.state.viewState {
                    case .signIn:
                        Text("登入")
                    case .signUp:
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
                    
                    if viewModel.state.viewState == .signIn {
                        Group {
                            Button("忘記密碼") {
//                                viewModel.setViewState(viewState: .resetPassword)
                                viewModel.state.viewState = .resetPassword
                            }
                            .foregroundColor(Color("BlueGreen"))
                            Spacer()
                        }
                    }
                    
                    Button {
                        if viewModel.state.viewState == .signUp || viewModel.state.viewState == .resetPassword {
                            viewModel.state.viewState = .signIn
                        }
                        else {
                            viewModel.state.viewState = .signUp
                        }
                    } label: {
                        if viewModel.state.viewState == .signIn {
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
            .animation(.easeIn, value: viewModel.state.viewState)
            .toolbar {
                ToolbarItem {
                    Button {
                        presentationMode.wrappedValue.dismiss()
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
        LoginView(viewModel: LoginViewModel(initialState: LoginViewState()))
            .previewInterfaceOrientation(.portrait)
    }
}
