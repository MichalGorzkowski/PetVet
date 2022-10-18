//
//  CustomTextField.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 29/04/2022.
//

import SwiftUI

struct CustomTextField: View {
    let imageName: String
    let text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                Text(text)
                
                Spacer()
            }
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(imageName: "person",
                        text: "Benny")
    }
}
