//
//  AntiParasite.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/05/2022.
//

import FirebaseFirestoreSwift
import Firebase

struct AntiParasite: Identifiable, Decodable {
    @DocumentID var id: String?
    let medicineName: String
    let lot: String
    let expirationDate: String
    let applicationDate: String
    let comment: String
    let petId: String
    let timestamp: Timestamp
    let uid: String
    
    var user: User?
}
