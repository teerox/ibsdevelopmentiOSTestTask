//
//  Loginview.swift
//  IBSdevelopmentiOSTestTask
//
//  Created by Mac on 02/10/2022.
//

import SwiftUI

struct Loginview: View {
    @ObservedObject var viewModel: ViewModel
    @State var isShowing = true
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Login")
                .bold()
                .font(.title)
            VStack(spacing:0){
                FloatingTextField(placeHolder: "Email",
                                  text:$viewModel.email,
                                  strokeColor: $viewModel.emailTextFieldColor,
                                  showError: $viewModel.showEmailError,
                                  errorMessage: $viewModel.emailErrorMessage,
                                  isSecure: .constant(false))
                
                FloatingTextField(placeHolder: "Password",
                                  text: $viewModel.password,
                                  strokeColor: $viewModel.passwordTextFieldColor,
                                  showError: $viewModel.showPasswordError,
                                  errorMessage: $viewModel.passwordErrormessage,
                                  isSecure: .constant(true))
            }
            
            ZStack {
                Button(action: viewModel.login) {
                       Text("Login")
                           .frame(minWidth: 0, maxWidth: .infinity)
                           .font(.system(size: 20))
                           .padding()
                           .foregroundColor(Color("textColor"))
                           .overlay(
                               RoundedRectangle(cornerRadius: 10)
                                   .stroke(Color.white)
                       )
                   }
                   .background(Color("buttonColor"))
                   .cornerRadius(10)
                  .padding()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(Color("buttonColor"))
            }
        }
    }
}

struct Loginview_Previews: PreviewProvider {
    static var previews: some View {
        Loginview(viewModel: ViewModel())
        Loginview(viewModel: ViewModel()).preferredColorScheme(.dark)
    }
}
