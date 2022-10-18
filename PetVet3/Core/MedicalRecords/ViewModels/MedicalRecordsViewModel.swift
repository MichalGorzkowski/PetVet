//
//  MedicalRecordsViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/06/2022.
//

import Foundation
import Firebase
import FirebaseAuth

class MedicalRecordsViewModel: ObservableObject {
    @Published var medicalRecords = [MedicalRecord]()
    private let service = MedicalRecordService()
    private let userService = UserService()
    private var currentUser: User?
    private var userSession: FirebaseAuth.User?
    
    init() {
        self.fetchUserMedicalRecords()
        self.userSession = Auth.auth().currentUser
    }
    
    func fetchUserMedicalRecords() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        fetchUser()
        
        guard let petId = currentUser?.currentPet else { return }
        
        if petId != nil {
            service.fetchMedicalRecords(forUid: uid, petId: petId) { medicalRecords in
                self.medicalRecords = medicalRecords
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
