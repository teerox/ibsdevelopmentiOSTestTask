//
//  ViewModel.swift
//  IBSdevelopmentiOSTestTask
//
//  Created by Mac on 02/10/2022.
//

import Foundation
import Combine
import SwiftUI

final class ViewModel: ObservableObject {
    
    private var publishers = Set<AnyCancellable>()
    // Input values from view
    @Published var email = ""
    @Published var password = ""
    @Published var emailTextFieldColor = Color.secondary
    @Published var passwordTextFieldColor = Color.secondary
    @Published var showPasswordError = false
    @Published var showEmailError = false
    @Published var passwordErrormessage = "Wrong Passowrd"
    @Published var emailErrorMessage = "Invalid Email"
    @Published var loginSuccess = false

    
    init() {
      
    }
    
    var isUserEmailValid: AnyPublisher<Bool, Never> {
        $email
            .map { email in
                let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                if emailPredicate.evaluate(with: email) {
                    self.emailTextFieldColor = .secondary
                    self.showEmailError = false
                    return true
                } else {
                    self.emailTextFieldColor = .red
                    self.showEmailError = true
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordValid: AnyPublisher<Bool, Never> {
        $password
            .map { password in
                if password.count >= 6 {
                    self.passwordTextFieldColor = .secondary
                    self.showPasswordError = false
                    return true
                } else {
                    self.passwordTextFieldColor = .red
                    self.showPasswordError = true
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
    
    var isLoginValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            isUserEmailValid,
            isPasswordValid)
        .map {
            isEmailValid,
            isPasswordValid in
            return isEmailValid && isPasswordValid
        }
        .eraseToAnyPublisher()
    }
    
    func login() {
        isLoginValid
            .receive(on: RunLoop.main)
            .assign(to: \.loginSuccess, on: self)
            .store(in: &publishers)
    }
}
