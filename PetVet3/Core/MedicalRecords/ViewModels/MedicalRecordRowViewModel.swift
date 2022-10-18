//
//  MedicalRecordRowViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/06/2022.
//

import Foundation

class MedicalRecordRowViewModel: ObservableObject {
    let medicalRecord: MedicalRecord
    private let service = MedicalRecordService()
    
    init(medicalRecord: MedicalRecord) {
        self.medicalRecord = medicalRecord
    }
    
    func deleteMedicalRecord() {
        service.deleteMedicalRecord(medicalRecord)
    }
}
