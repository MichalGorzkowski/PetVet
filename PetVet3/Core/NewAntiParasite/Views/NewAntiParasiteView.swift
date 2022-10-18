//
//  NewAntiParasiteView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 26/04/2022.
//

import SwiftUI

struct NewAntiParasiteView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = UploadAntiParasiteViewModel()
    
    var body: some View {
        VStack {
            SmallHeaderView(title: "Dodawanie nowego medykamentu")
            
            VStack(spacing: 40) {
                CustomInputField(imageName: "character.cursor.ibeam",
                                 placeholderText: "Nazwa preparatu",
                                 prompt: "",
                                 text: $viewModel.medicineName)
                
                CustomInputField(imageName: "number",
                                 placeholderText: "Partia",
                                 prompt: viewModel.lotPrompt,
                                 text: $viewModel.lot)
                
                CustomDatePickerField(imageName: "calendar",
                                      placeholderText: "Data ważności",
                                      prompt: "",
                                      date: $viewModel.expirationDate)
                
                CustomDatePickerField(imageName: "calendar",
                                      placeholderText: "Data podania",
                                      prompt: "",
                                      date: $viewModel.applicationDate,
                                      fromDate: viewModel.date1950,
                                      toDate: viewModel.today)
                
                CustomInputField(imageName: "character.cursor.ibeam",
                                 placeholderText: "Komentarz",
                                 prompt: "",
                                 text: $viewModel.comment)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            Button {
                viewModel.uploadAntiParasite(medicineName: viewModel.medicineName,
                                             lot: viewModel.lot,
                                             expirationDate: viewModel.expirationDate,
                                             applicationDate: viewModel.applicationDate,
                                             comment: viewModel.comment)
            } label: {
                Text("Dodaj medykament")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .opacity(viewModel.isFormComplete ? 1 : 0.6)
            .disabled(!viewModel.isFormComplete)
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Anuluj")
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
        .onReceive(viewModel.$didUploadAntiParasite) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .ignoresSafeArea()
    }
}

struct NewAntiParasiteView_Previews: PreviewProvider {
    static var previews: some View {
        NewAntiParasiteView()
    }
}
