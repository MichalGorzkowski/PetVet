//
//  VaccinationsViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 06/05/2022.
//

import Foundation
import Firebase
import FirebaseAuth

class VaccinationsViewModel: ObservableObject {
    @Published var vaccinations = [Vaccination]()
    private let service = VaccinationService()
    private let userService = UserService()
    private var currentUser: User?
    private var userSession: FirebaseAuth.User?
    
    init() {
        self.fetchUserVaccinations()
        self.userSession = Auth.auth().currentUser
    }
    
    func fetchUserVaccinations() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        fetchUser()
        
        guard let petId = currentUser?.currentPet else { return }
        
        if petId != nil {
            service.fetchVaccinations(forUid: uid, petId: petId) { vaccinations in
                self.vaccinations = vaccinations
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
