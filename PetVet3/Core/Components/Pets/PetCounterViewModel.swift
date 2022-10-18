//
//  PetCounterViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 08/06/2022.
//

import Foundation

class PetCounterViewModel: ObservableObject {
    @Published var text: String
    
    init() {
        let changePetViewModel = ChangePetViewModel()
        changePetViewModel.fetchUserPets()
        if changePetViewModel.pets.count == 1 {
            self.text = "zwierzę"
        } else if changePetViewModel.pets.count < 5 {
            //print("DEBUG: 2-4 pets counted")
            self.text = "zwierzęta"
        } else {
            //print("DEBUG: 5 or more pets counted")
            self.text = "zwierząt"
        }
    }
}
