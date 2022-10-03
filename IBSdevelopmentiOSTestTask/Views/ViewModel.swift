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
    private let repository = Repository()
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
    @Published var searchText = ""
    @Published var allData: [Result] = []
    @Published var searchResult: [Result] = []
    
    init() {
        $searchText
            .map({ (string) -> String? in
                if string.isEmpty {
                    self.searchResult = self.allData
                    return nil
                }
                return string
            }) // prevents sending numerous requests and sends nil if the count of the characters is less than 1.
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
            } receiveValue: { [self] (searchField) in
                searchItems(searchText: searchField)
            }.store(in: &publishers)
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
    
    func getAllData() {
        repository.fetchAllData()
            .sink { _ in
            } receiveValue: { res in
                self.searchResult = res
                self.allData = res
            }
            .store(in: &publishers)
    }
    
    private func searchItems(searchText: String) {
        var searchResults: [Result] {
             if searchText.isEmpty {
                 return allData
             } else {
                 return allData.filter {
                     $0.name?.first?.contains(searchText) ?? false || $0.name?.last?.contains(searchText) ?? false
                 }
             }
         }
        self.searchResult = searchResults
    }
}
