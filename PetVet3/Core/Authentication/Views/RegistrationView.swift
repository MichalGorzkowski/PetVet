//
//  RegistrationView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            NavigationLink(destination: ProfilePhotoSelectorView(),
                           isActive: $authViewModel.didAuthenticateUser,
                           label: { })
            
            TwoLineHeaderView(titleFirst: "Rozpocznij.",
                              titleSecond: "Utwórz konto")
            
            VStack(spacing: 40) {
                CustomInputField(imageName: "envelope",
                                placeholderText: "Email",
                                prompt: viewModel.emailPrompt,
                                text: $viewModel.email)
                
                CustomInputField(imageName: "person",
                                placeholderText: "Login",
                                prompt: "",
                                text: $viewModel.username)
                
                CustomInputField(imageName: "person",
                                placeholderText: "Imię i nazwisko",
                                prompt: "",
                                text: $viewModel.fullname)
                
                CustomInputField(imageName: "lock",
                                placeholderText: "Hasło",
                                prompt: viewModel.passwordPrompt,
                                text: $viewModel.password,
                                isSecureField: true)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            Button {
                authViewModel.register(withEmail: viewModel.email,
                                       password: viewModel.password,
                                       fullname: viewModel.fullname,
                                       username: viewModel.username)
                //viewModel.cleanAfterSignUp() // clears the fields
            } label: {
                Text("Zarejestruj się")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .opacity(viewModel.isSignUpComplete ? 1 : 0.6)
            .disabled(!viewModel.isSignUpComplete)
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
        
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Masz już konto?")
                        .font(.footnote)
                    
                    Text("Zaloguj się")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)

        }
        .ignoresSafeArea()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
