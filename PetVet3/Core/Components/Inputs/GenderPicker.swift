//
//  GenderPicker.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 05/06/2022.
//

import SwiftUI

struct GenderPicker: View {
    @Binding var selection: String
    let filterOptions: [String] = ["Wybierz", "Samiec", "Samica"]
    var prompt: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("genderIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                Text("Płeć")
                    .foregroundColor(Color(.lightGray))
                
                Picker(
                    selection: $selection,
                    label:
                        HStack {
                            Text(selection)
                                .foregroundColor(Color(.darkGray))
                        },
                    content: {
                        ForEach(filterOptions, id: \.self) { option in
                            Text(option)
                                .tag(option)
                        }
                    }
                )
                .pickerStyle(MenuPickerStyle())
            }
            
            Text(prompt)
                .font(.caption)
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}

//struct GenderPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        GenderPicker()
//    }
//}
