//
//  AntiParasiteService.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/05/2022.
//

import Firebase

struct AntiParasiteService {
    func uploadAntiParasite(medicineName: String,
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
        
        Firestore.firestore().collection("anti_parasites").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload anti parasite with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                completion(true)
            }
    }
    
    func deleteAntiParasite(_ antiParasite: AntiParasite) {
        guard let antiParasiteId = antiParasite.id else { return }
        
        Firestore.firestore().collection("anti_parasites").document(antiParasiteId).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func fetchAntiParasites(completion: @escaping([AntiParasite]) -> Void) {
        Firestore.firestore().collection("anti_parasites")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let antiParasites = documents.compactMap({ try? $0.data(as: AntiParasite.self) })
                completion(antiParasites)
            }
    }
    
    func fetchAntiParasites(forUid uid: String, completion: @escaping([AntiParasite]) -> Void) {
        Firestore.firestore().collection("anti_parasites")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let antiParasites = documents.compactMap({ try? $0.data(as: AntiParasite.self) })
                completion(antiParasites.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
    func fetchAntiParasites(forUid uid: String, petId: String, completion: @escaping([AntiParasite]) -> Void) {
        Firestore.firestore().collection("anti_parasites")
            .whereField("petId", isEqualTo: petId)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let antiParasites = documents.compactMap({ try? $0.data(as: AntiParasite.self) })
                completion(antiParasites.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
}
