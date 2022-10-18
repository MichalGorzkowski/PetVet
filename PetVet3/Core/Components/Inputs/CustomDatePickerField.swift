//
//  CustomDatePickerField.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 31/05/2022.
//

import SwiftUI

struct CustomDatePickerField: View {
    let imageName: String
    let placeholderText: String
    var prompt: String
    @Binding var date: Date
    var fromDate: Date? = nil
    var toDate: Date? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                if fromDate != nil && toDate != nil {
                    DatePicker(selection: $date,
                               in: fromDate!...toDate!,
                               displayedComponents: [.date]) {
                        Text(placeholderText)
                            .foregroundColor(Color(.lightGray))
                    }
                    .environment(\.locale, Locale.init(identifier: "pl"))
                } else {
                    DatePicker(selection: $date,
                               displayedComponents: [.date]) {
                        Text(placeholderText)
                            .foregroundColor(Color(.lightGray))
                    }
                    .environment(\.locale, Locale.init(identifier: "pl"))
                }
            }
            
            Text(prompt)
                .font(.caption)
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}

//struct CustomDatePickerField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomDatePickerField()
//    }
//}
