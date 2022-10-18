//
//  ForgotPasswordView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/06/2022.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        VStack {
            TwoLineHeaderView(titleFirst: "Zapomniałeś?",
                              titleSecond: "Zresetuj hasło")

            CustomInputField(imageName: "envelope",
                             placeholderText: "Email",
                             prompt: viewModel.emailPrompt,
                             text: $viewModel.email)
            .padding(.horizontal, 32)
            .padding(.top, 44)

            Button {
                authViewModel.sendPasswordReset(withEmail: viewModel.email)
                print("DEBUG: Reset password button tapped with email \(viewModel.email)")
                //viewModel.cleanAfterReset()
                viewModel.isAlertPresented = true
            } label: {
                Text("Zresetuj hasło")
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
            .alert("Jeśli istnieje takie konto, wysłaliśmy wiadomość dotyczącą resetu hasła.", isPresented: $viewModel.isAlertPresented) {
                Button("OK", role: .cancel) {
                    presentationMode.wrappedValue.dismiss()
                }
            }

            Spacer()

            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Anuluj")
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
            .padding(.bottom, 32)
        }
        .ignoresSafeArea()
    }
}

struct ForgorPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
