//
//  Pet.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/05/2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Pet: Identifiable, Decodable {
    @DocumentID var id: String?
    let name: String
    let dateOfBirth: String
    let breed: String
    let color: String
    let microchipNumber: String
    let sex: String
    let weight: Double
}
