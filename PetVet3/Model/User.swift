//
//  User.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 06/05/2022.
//

import FirebaseFirestoreSwift
// jak cos przestanie dzialac to usunac ponizsza linie
import Firebase

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
    var currentPet: String?
}
