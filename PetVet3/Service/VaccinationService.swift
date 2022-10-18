//
//  VaccinationService.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 06/05/2022.
//

import Firebase

struct VaccinationService {    
    func uploadVaccination(medicineName: String,
                           lot: String,
                           expirationDate: String,
                           applicationDate: String,
                           comment: String,
                           petId: String,
                           completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "medicineName": medicineName,
                    "lot": lot,
                    "expirationDate": expirationDate,
                    "applicationDate": applicationDate,
                    "comment": comment,
                    "petId": petId,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("vaccinations").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload vaccination with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                completion(true)
            }
    }
    
    func deleteVaccination(_ vaccination: Vaccination) {
        guard let vaccinationId = vaccination.id else { return }
        
        Firestore.firestore().collection("vaccinations").document(vaccinationId).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func fetchVaccinations(completion: @escaping([Vaccination]) -> Void) {
        Firestore.firestore().collection("vaccinations")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let vaccinations = documents.compactMap({ try? $0.data(as: Vaccination.self) })
                completion(vaccinations)
            }
    }
    
    func fetchVaccinations(forUid uid: String, completion: @escaping([Vaccination]) -> Void) {
        Firestore.firestore().collection("vaccinations")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let vaccinations = documents.compactMap({ try? $0.data(as: Vaccination.self) })
                completion(vaccinations.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
    func fetchVaccinations(forUid uid: String, petId: String, completion: @escaping([Vaccination]) -> Void) {
        Firestore.firestore().collection("vaccinations")
            .whereField("petId", isEqualTo: petId)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let vaccinations = documents.compactMap({ try? $0.data(as: Vaccination.self) })
                completion(vaccinations.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
}
