//
//  DetailedInformationViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 12/05/2022.
//

import Foundation
import SwiftUI
import Firebase

class DetailedInformationViewModel: ObservableObject {
    @Published var activePet: Pet?
    @ObservedObject var authViewModel = AuthViewModel()
    
    private let service = PetService()
    
    init() {
        self.getPetData()
    }
    
    func getPetData() {
        authViewModel.fetchUser()
        guard let petId = authViewModel.currentUser?.currentPet else { return }
        
        service.getActivePetData(forPetId: petId) { pet in
            self.activePet = pet
        }
    }
}
