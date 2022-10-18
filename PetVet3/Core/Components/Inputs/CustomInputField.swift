//
//  CustomInputField.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 26/04/2022.
//

import SwiftUI

struct CustomInputField: View {
    let imageName: String
    let placeholderText: String
    var prompt: String
    @Binding var text: String
    var isSecureField: Bool? = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                if isSecureField ?? false {
                    SecureField(placeholderText, text: $text)
                } else {
                    TextField(placeholderText, text: $text)
                }
            }
            
            Text(prompt)
                .font(.caption)
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope",
                         placeholderText: "Email",
                         prompt: "This is a prompt to be displayed",
                         text: .constant(""),
                         isSecureField: false)
    }
}
