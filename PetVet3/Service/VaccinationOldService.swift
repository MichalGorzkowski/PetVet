//
//  VaccinationOldService.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 06/05/2022.
//

import Firebase

struct VaccinationOldService {
    func uploadVaccination(caption: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "caption": caption,
                    "likes": 0,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("vaccinationsOld").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload vaccination with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                completion(true)
            }
    }
    
    func fetchVaccinations() {
        Firestore.firestore().collection("vaccinationsOld").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { doc in
                print(doc.data())
            }
        }
    }
}
