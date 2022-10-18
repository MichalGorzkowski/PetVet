//
//  NewMedicalRecordView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 03/05/2022.
//

import SwiftUI

struct NewMedicalRecordView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = UploadMedicalRecordViewModel()
    
    var body: some View {
        VStack {
            SmallHeaderView(title: "Dodawanie wizyty/zabiegu")

            VStack(spacing: 40) {
                CustomDatePickerField(imageName: "calendar",
                                      placeholderText: "Dawa wizyty",
                                      prompt: "",
                                      date: $viewModel.date)
                
                CustomInputField(imageName: "character.cursor.ibeam",
                                 placeholderText: "Cel wizyty",
                                 prompt: "",
                                 text: $viewModel.name)
                
                CustomInputField(imageName: "character.cursor.ibeam",
                                 placeholderText: "Szczegóły",
                                 prompt: "",
                                 text: $viewModel.description)
                
                CustomInputField(imageName: "character.cursor.ibeam",
                                 placeholderText: "Komentarz weterynarza",
                                 prompt: "",
                                 text: $viewModel.doctorsRecomendations)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            Button {
                viewModel.uploadMedicalRecord(date: viewModel.date,
                                              name: viewModel.name,
                                              description: viewModel.description,
                                              doctorsRecomendations: viewModel.doctorsRecomendations)
            } label: {
                Text("Dodaj wizytę/zabieg")
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
        .onReceive(viewModel.$didUploadMedicalRecord) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .onDisappear() {
            viewModel.shouldReload = true
        }
        .ignoresSafeArea()
    }
}

struct NewMedicalRecordView_Previews: PreviewProvider {
    static var previews: some View {
        NewMedicalRecordView()
    }
}
