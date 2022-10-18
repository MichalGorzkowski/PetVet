//
//  CustomNumberInputField.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 04/06/2022.
//

import SwiftUI

struct CustomNumberInputField: View {
    let imageName: String
    let placeholderText: String
    var prompt: String
    @Binding var text: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                Text("Waga")
                    .foregroundColor(Color(.lightGray))
                
                TextField(placeholderText, value: $text, format: .number)
                    .keyboardType(.numberPad)
            }
            
            Text(prompt)
                .font(.caption)
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}

//struct CustomInputField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomInputField(imageName: "envelope",
//                         placeholderText: "Email",
//                         prompt: "This is a prompt to be displayed",
//                         text: .constant(""))
//    }
//}
