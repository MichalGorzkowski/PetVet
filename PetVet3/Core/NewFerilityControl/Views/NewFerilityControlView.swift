//
//  NewFerilityControlView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 03/05/2022.
//

import SwiftUI

struct NewFerilityControlView: View {
    @State private var date = ""
    @State private var procedure = ""
    @State private var treatment = ""
    @State private var comment = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            SmallHeaderView(title: "Adding new Fertility Control Record")
            
            VStack(spacing: 40) {
                CustomInputField(imageName: "calendar",
                                 placeholderText: "Date",
                                 prompt: "",
                                 text: $date)
                
                CustomInputField(imageName: "character.cursor.ibeam",
                                 placeholderText: "Procedure",
                                 prompt: "",
                                 text: $procedure)
                
                CustomInputField(imageName: "character.cursor.ibeam",
                                 placeholderText: "Treatment",
                                 prompt: "",
                                 text: $treatment)
                
                CustomInputField(imageName: "character.cursor.ibeam",
                                 placeholderText: "Comment",
                                 prompt: "",
                                 text: $comment)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            Button {
                print("Add Fertility Control Record here...")
            } label: {
                Text("Add Fertility Control Record")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Cancel")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            
            /*
            HStack(alignment: .top) {
                Circle()
                    .frame(width: 64, height: 64)
                
                TextArea("Pill Name", text: $caption)
            }
            .padding()
            */
        }
        .ignoresSafeArea()
    }
}

struct NewFerilityControlView_Previews: PreviewProvider {
    static var previews: some View {
        NewFerilityControlView()
    }
}
