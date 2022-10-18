//
//  MedicalRecord.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/06/2022.
//

import FirebaseFirestoreSwift
import Firebase

struct MedicalRecord: Identifiable, Decodable {
    @DocumentID var id: String?
    let date: String
    let name: String
    let description: String
    let doctorsRecomendations: String
    
    let petId: String
    let timestamp: Timestamp
    let uid: String
    
    var user: User?
}
