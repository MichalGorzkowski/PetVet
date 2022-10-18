//
//  LoginView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = SignInViewModel()
    
    var body: some View {
        VStack {
            TwoLineHeaderView(titleFirst: "Hej.",
                              titleSecond: "Witaj ponownie.")
            
            VStack(spacing: 40) {
                CustomInputField(imageName: "envelope",
                                 placeholderText: "Email",
                                 prompt: viewModel.emailPrompt,
                                 text: $viewModel.email)
                
                CustomInputField(imageName: "lock",
                                 placeholderText: "Hasło",
                                 prompt: "",
                                 text: $viewModel.password,
                                 isSecureField: true)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            HStack {
                Spacer()
                
                NavigationLink {
                    ForgotPasswordView()
                        .navigationBarHidden(true)
                } label: {
                    Text("Zapomniałeś hasła?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                        .padding(.top)
                        .padding(.trailing, 24)
                }
                .padding(.bottom, 32)
                .foregroundColor(Color(.systemBlue))
            }
            
            Button {
                authViewModel.login(withEmail: viewModel.email, password: viewModel.password)
            } label: {
                Text("Zaloguj się")
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
            
            NavigationLink {
                RegistrationView()
                    .navigationBarHidden(true)
            } label: {
                HStack {
                    Text("Nie masz jeszcze konta?")
                        .font(.footnote)
                    
                    Text("Zarejestruj się")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(Color(.systemBlue))

        }
        .alert("Błędne dane logowania!", isPresented: $authViewModel.isLoginPasswordWrong) {
            Button("OK", role: .cancel) {
                authViewModel.isLoginPasswordWrong = false
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
