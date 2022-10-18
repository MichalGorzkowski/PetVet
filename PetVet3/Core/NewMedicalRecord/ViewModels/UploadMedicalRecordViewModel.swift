//
//  UploadMedicalRecordViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/06/2022.
//

import Foundation
import Firebase
import FirebaseAuth

class UploadMedicalRecordViewModel: ObservableObject {
    @Published var date = Date()
    @Published var name = ""
    @Published var description = ""
    @Published var doctorsRecomendations = ""
    @Published var petId = ""
    @Published var didUploadMedicalRecord = false
    @Published var shouldReload = false
    
    let service = MedicalRecordService()
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
    
    func uploadMedicalRecord(date: Date,
                             name: String,
                             description: String,
                             doctorsRecomendations: String) {
        fetchUser()
        guard let petId = currentUser?.currentPet else { return }
        
        if petId != nil {
            service.uploadMedicalRecord(date: dateFormatter.string(from: date),
                                        name: name,
                                        description: description,
                                        doctorsRecomendations: doctorsRecomendations,
                                        petId: petId) { success in
                if success {
                    self.didUploadMedicalRecord = true
                    self.shouldReload = true
                } else {
                    // show errors here...
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
}
