//
//  VaccinationRowViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/05/2022.
//

import Foundation

class VaccinationRowViewModel: ObservableObject {
    let vaccination: Vaccination
    private let service = VaccinationService()
    
    init(vaccination: Vaccination) {
        self.vaccination = vaccination
    }
    
    func deleteVaccination() {
        service.deleteVaccination(vaccination)
    }
}
