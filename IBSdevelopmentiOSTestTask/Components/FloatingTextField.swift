//
//  FloatingTextField.swift
//  IBSdevelopmentiOSTestTask
//
//  Created by Mac on 02/10/2022.
//

import SwiftUI

struct FloatingTextField: View {
    @Binding var text: String
    @Binding var strokeColor: Color
    @Binding var showError: Bool
    @Binding var errorMessage: String
    @Binding var isSecure: Bool
    @State private var isEditing = false
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    
    public init(placeHolder: String,
                text: Binding<String>,
                strokeColor: Binding<Color>,
                showError: Binding<Bool>,
                errorMessage: Binding<String>,
                isSecure: Binding<Bool>) {
        self._text = text
        self.placeHolderText = placeHolder
        self._strokeColor = strokeColor
        self._showError = showError
        self._errorMessage = errorMessage
        self._isSecure = isSecure
    }
    
    var shouldPlaceHolderMove: Bool {
        withAnimation(.linear) {
            isEditing || (text.count != 0)
        }
    }
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                
                if isSecure {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(placeHolderText)
                        SecureField("", text: $text)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(strokeColor, lineWidth: 1)
                            .frame(height: textFieldHeight))
                        .foregroundColor(Color.primary)
                        .accentColor(Color.secondary)
                        .keyboardType(.emailAddress)
                    }
                } else {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(placeHolderText)
                            
                        TextField("", text: $text)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(strokeColor, lineWidth: 1)
                            .frame(height: textFieldHeight))
                            .foregroundColor(Color.primary)
                            .accentColor(Color.secondary)
                    }
                    .padding(.top, 15)
                }
            }
            
            if showError {
                ///Error Placeholder
                Text(errorMessage)
                .foregroundColor(strokeColor)
            }
        }
        .padding()
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTextField(placeHolder: "Name",
                          text: .constant(""),
                          strokeColor: .constant(Color.secondary),
                          showError: .constant(false),
                          errorMessage: .constant("Invalid Mail"),
                          isSecure: .constant(false))
            .previewLayout(.sizeThatFits)
        
        FloatingTextField(placeHolder: "Email",
                          text: .constant(""),
                          strokeColor: .constant(Color.red),
                          showError: .constant(true),
                          errorMessage: .constant("Invalid Email"),
                          isSecure: .constant(false))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        
        FloatingTextField(placeHolder: "Password",
                          text: .constant(""),
                          strokeColor: .constant(Color.red),
                          showError: .constant(true),
                          errorMessage: .constant("Wrong password"),
                          isSecure: .constant(true))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
