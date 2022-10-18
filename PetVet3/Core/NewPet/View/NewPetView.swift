//
//  AddNewPetView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 06/05/2022.
//

import SwiftUI

struct NewPetView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = UploadPetViewModel()
    
    var body: some View {
        VStack {
            SmallHeaderView(title: "Dodaj nowe zwierzę")
            
            VStack(spacing: 20) {
                CustomInputField(imageName: "person",
                                 placeholderText: "Imię",
                                 prompt: "",
                                 text: $viewModel.name)
                
                CustomInputField(imageName: "number",
                                 placeholderText: "Numer mikrochipa",
                                 prompt: viewModel.microchipNumberPrompt,
                                 text: $viewModel.microchipNumber)
                
                CustomDatePickerField(imageName: "calendar",
                                      placeholderText: "Data urodzenia",
                                      prompt: "",
                                      date: $viewModel.dateOfBirth,
                                      fromDate: viewModel.date1950,
                                      toDate: viewModel.today)
                
                CustomInputField(imageName: "pawprint",
                                 placeholderText: "Rasa",
                                 prompt: viewModel.breedPrompt,
                                 text: $viewModel.breed)
                
                CustomInputField(imageName: "eyedropper.halffull",
                                 placeholderText: "Kolor",
                                 prompt: viewModel.colorPrompt,
                                 text: $viewModel.color)
                
//                CustomInputField(imageName: "arrow.triangle.branch",
//                                 placeholderText: "Sex",
//                                 prompt: "",
//                                 text: $viewModel.sex)
                GenderPicker(selection: $viewModel.sex, prompt: "")
                
                CustomNumberInputField(imageName: "scalemass",
                                 placeholderText: "Waga",
                                 //prompt: viewModel.weightPrompt,
                                 prompt: "",
                                 text: $viewModel.weight)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            Button {
                viewModel.uploadPet(name: viewModel.name,
                                    dateOfBirth: viewModel.dateOfBirth,
                                    breed: viewModel.breed,
                                    color: viewModel.color,
                                    microchipNumber: viewModel.microchipNumber,
                                    sex: viewModel.sex,
                                    weight: viewModel.weight)
                //viewModel.cleanAfterSignUp() // clears the fields
            } label: {
                Text("Dodaj zwierzę")
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
            
        }
        .onReceive(viewModel.$didUploadPet) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .ignoresSafeArea()
    }
}

struct AddNewPetView_Previews: PreviewProvider {
    static var previews: some View {
        NewPetView()
    }
}
