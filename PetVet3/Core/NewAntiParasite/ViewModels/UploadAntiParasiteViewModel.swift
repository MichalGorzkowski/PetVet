//
//  UploadAntiParasiteViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/05/2022.
//

import Foundation
import Firebase
import FirebaseAuth

class UploadAntiParasiteViewModel: ObservableObject {
    @Published var medicineName = ""
    @Published var lot = ""
    @Published var expirationDate = Date()
    @Published var applicationDate = Date()
    @Published var comment = ""
    @Published var petId = ""
    @Published var didUploadAntiParasite = false
    @Published var date1950: Date = Calendar.current.date(from: DateComponents(year: 1950)) ?? Date()
    @Published var today: Date = Date()
    let service = AntiParasiteService()
    private let userService = UserService()
    private var currentUser: User?
    private var userSession: FirebaseAuth.User?
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "pl-PL")
        return formatter
    }
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func uploadAntiParasite(medicineName: String,
                           lot: String,
                           expirationDate: Date,
                           applicationDate: Date,
                           comment: String) {
        fetchUser()
        guard let petId = currentUser?.currentPet else { return }
        
        if petId != nil {
            service.uploadAntiParasite(medicineName: medicineName,
                                       lot: lot,
                                       expirationDate: dateFormatter.string(from: expirationDate),
                                       applicationDate: dateFormatter.string(from: applicationDate),
                                       comment: comment,
                                       petId: petId) { success in
                if success {
                    self.didUploadAntiParasite = true
                } else {
                    // show error message to user
                }
            }
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        userService.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
    
    // VALIDATION
    
    func isLotValid() -> Bool {
        let LotTest = NSPredicate(format: "SELF MATCHES %@",
        "^[a-zA-Z0-9]+$") // letters and numbers only
        return LotTest.evaluate(with: lot)
    }
    
    var isFormComplete: Bool {
        if !isLotValid() {
            return false
        }
        return true
    }
    
    // VALIDATION PROMPT STRINGS
    
    var lotPrompt: String {
        if isLotValid() {
            return ""
        } else {
            return "Może składać się tylko z liter i cyfr"
        }
    }
    
    func cleanAfterSignUp() {
        medicineName = ""
        lot = ""
        expirationDate = Date()
        applicationDate = Date()
        comment = ""
        petId = ""
    }
}
