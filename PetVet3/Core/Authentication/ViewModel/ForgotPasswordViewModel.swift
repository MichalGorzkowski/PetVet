//
//  ForgotPasswordViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/06/2022.
//

import Foundation

class ForgotPasswordViewModel: ObservableObject {
    @Published var email = ""
    @Published var isAlertPresented = false

    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
        "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
    }
    
    var emailPrompt: String {
        if isEmailValid() {
            return ""
        } else {
            return "Wprowadź poprawny adres email."
        }
    }
    
    var isSignUpComplete: Bool {
        if !isEmailValid() {
            return false
        }
        return true
    }
    
    func cleanAfterReset() {
        email = ""
    }
}
