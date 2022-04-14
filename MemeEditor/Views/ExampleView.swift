//
//  ExampleView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/4/11.
//

import SwiftUI

import SwiftUI

struct ExampleState: Equatable {
    var email: String = ""
    var password: String = ""
    var passwordError: String?
    var isSignUpButtonEnabled: Bool = false
}

final class ExampleViewModel: ObservableObject {
    // MARK: - Properties
    @Published var state: ExampleState

    // MARK: - Initialization
    init(initialState: ExampleState) {
        self.state = initialState
    }

    // MARK: - Public Methods
    func updateEmail(_ newValue: String) {
        state.email = newValue
        updateButtonState()
    }

    func updatePassword(_ newValue: String) {
        state.passwordError = nil

        guard !(newValue.count > 12) else {
            return // Passwords should not have more than 12 characters.
        }

        state.password = newValue
        updateButtonState()
    }

    func performSignUp() {
        if state.password.count < 6 {
            state.passwordError = "The Password should have at least 6 characters."
        }
        // Do aditional validations and send the data to the server...
    }

    // MARK: - Private Methods
    private func updateButtonState() {
        state.isSignUpButtonEnabled = isValidForm()
    }

    private func isValidForm() -> Bool {
        return !state.email.isEmpty && !state.password.isEmpty
    }
}

struct ExampleView: View {
    // MARK: - Dependencies
    @StateObject var viewModel: ExampleViewModel

    // MARK: - View Content
    var body: some View {
        Form {
            Section(header: Text("E-mail")) {
                TextField(
                    "example@mail.com",
                    text: .init(
                        get: { [viewModel] in viewModel.state.email },
                        set: { [viewModel] in viewModel.updateEmail($0) }
                    )
                )
            }
            Section(header: Text("Password")) {
                SecureField(
                    "xxxxxx",
                    text: .init(
                        get: { [viewModel] in viewModel.state.password },
                        set: { [viewModel] in viewModel.updatePassword($0) }
                    )
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

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView(viewModel: ExampleViewModel(initialState: ExampleState()))
    }
}
