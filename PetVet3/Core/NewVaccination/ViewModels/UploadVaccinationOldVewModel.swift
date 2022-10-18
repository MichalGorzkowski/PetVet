//
//  UploadVaccinationVewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 06/05/2022.
//

import Foundation

class UploadVaccinationOldViewModel: ObservableObject {
    @Published var didUploadVaccination = false
    let service = VaccinationOldService()
    
    func uploadVaccination(withCaption caption: String) {
        service.uploadVaccination(caption: caption) { success in
            if success {
                self.didUploadVaccination = true
            } else {
                // show error message to user
            }
        }
    }
}
