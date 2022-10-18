//
//  AntiParasitesViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/05/2022.
//

import Foundation
import Firebase
import FirebaseAuth

class AntiParasitesViewModel: ObservableObject {
    @Published var antiParasites = [AntiParasite]()
    private let service = AntiParasiteService()
    private let userService = UserService()
    private var currentUser: User?
    private var userSession: FirebaseAuth.User?
    
    init() {
        self.fetchUserAntiParasites()
        self.userSession = Auth.auth().currentUser
    }
    
    func fetchUserAntiParasites() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        fetchUser()
        
        guard let petId = currentUser?.currentPet else { return }

        if petId != nil {
            service.fetchAntiParasites(forUid: uid, petId: petId) { antiParasites in
                self.antiParasites = antiParasites
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
