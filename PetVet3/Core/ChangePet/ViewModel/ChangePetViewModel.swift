//
//  ChangePetViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/05/2022.
//

import Foundation
import Firebase

class ChangePetViewModel: ObservableObject {
    @Published var pets = [Pet]()
    //@Published var currentPet: Pet?
    private let service = PetService()
    
    init() {
        self.fetchUserPets()
    }
    
    func fetchUserPets() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        service.fetchPets(forUid: uid) { pets in
            self.pets = pets
        }
    }
    
//    func setActive(pet: Pet) {
//        self.currentPet = pet
//    }
}
