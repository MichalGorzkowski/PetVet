//
//  ChangePetRowViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 12/05/2022.
//

import Foundation

class ChangePetRowViewModel: ObservableObject {
    let pet: Pet
    private let service = PetService()
    @Published var isDeleteAlertPresented = false
    
    init(pet: Pet) {
        self.pet = pet
    }
    
    func setActive() {
        service.setActive(pet)
    }
    
    func delete() {
        service.deletePet(pet)
    }
}
