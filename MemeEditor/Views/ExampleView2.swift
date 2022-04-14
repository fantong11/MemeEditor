//
//  ExampleView2.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/4/11.
//

import SwiftUI
//import Combine

struct ExampleState2: Equatable {
    var email: String = ""
    var password: String = ""
    var passwordError: String?
    var isSignUpButtonEnabled: Bool = false
}


final class ExampleViewModel2: StateBindingViewModel<ExampleState2> {
    // MARK: - Public Methods
    func performSignUp() {
        if state.password.count < 6 {
            state.passwordError = "The Password should have at least 6 characters."
        }
        // Do aditional validations and send the data to the server...
    }

    // MARK: - StateBindingViewModel Conformance
    override func stateWillChangeValue<Value>(_ keyPath: PartialKeyPath<ExampleState2>, newValue: Value) -> Bool where Value: Equatable {
        switch (keyPath, newValue) {
        case let (\ExampleState2.password, newValue as String):
            state.passwordError = nil
            return newValue.count <= 12
        default:
            return true
        }
    }

    override func onStateChange(_ keyPath: PartialKeyPath<ExampleState2>) {
        state.isSignUpButtonEnabled = isValidForm()
    }

    // MARK: - Private Methods
    private func isValidForm() -> Bool {
        return !state.email.isEmpty && !state.password.isEmpty
    }
}

struct ExampleView2: View {
    // MARK: - Dependencies
    @StateObject var viewModel: ExampleViewModel2

    // MARK: - View Content
    var body: some View {
        Form {
            Section(header: Text("E-mail")) {
                TextField(
                    "example@mail.com",
                    text: viewModel.binding(\.email)
                )
            }
            Section(header: Text("Password")) {
                SecureField(
                    "xxxxxx",
                    text: viewModel.binding(\.password)
                )
                if let passwordError = viewModel.state.passwordError {
                    Text(passwordError)
                        .font(.title3)
                        .foregroundColor(.red)
                }
            }
            Button(
                "Sign Up",
                action: viewModel.performSignUp
            )
            .disabled(viewModel.state.isSignUpButtonEnabled == false)
        }
    }
}

struct ExampleView2_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView2(viewModel: ExampleViewModel2(initialState: ExampleState2()))
    }
}
