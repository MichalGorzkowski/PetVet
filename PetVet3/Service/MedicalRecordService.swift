//
//  MedicalRecordService.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/06/2022.
//

import Firebase

struct MedicalRecordService {
    func uploadMedicalRecord(date: String,
                             name: String,
                             description: String,
                             doctorsRecomendations: String,
                             petId: String,
                             completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "date": date,
                    "name": name,
                    "description": description,
                    "doctorsRecomendations": doctorsRecomendations,
                    "petId": petId,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("medical_records").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload medical record with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                completion(true)
            }
    }
    
    func deleteMedicalRecord(_ medicalRecord: MedicalRecord) {
        guard let medicalRecordId = medicalRecord.id else { return }
        
        Firestore.firestore().collection("medical_records").document(medicalRecordId).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func fetchMedicalRecords(completion: @escaping([MedicalRecord]) -> Void) {
        Firestore.firestore().collection("medical_records")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let medicalRecords = documents.compactMap({ try? $0.data(as: MedicalRecord.self) })
                completion(medicalRecords)
            }
    }
    
    func fetchMedicalRecords(forUid uid: String, completion: @escaping([MedicalRecord]) -> Void) {
        Firestore.firestore().collection("medical_records")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let medicalRecords = documents.compactMap({ try? $0.data(as: MedicalRecord.self) })
                completion(medicalRecords.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
    func fetchMedicalRecords(forUid uid: String, petId: String, completion: @escaping([MedicalRecord]) -> Void) {
        Firestore.firestore().collection("medical_records")
            .whereField("petId", isEqualTo: petId)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let medicalRecords = documents.compactMap({ try? $0.data(as: MedicalRecord.self) })
                completion(medicalRecords.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
}
