//
//  Clinic.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 02/06/2022.
//

import FirebaseFirestoreSwift
import Firebase
import MapKit

struct Clinic: Identifiable, Decodable, Equatable  {
    @DocumentID var id: String?
    let name: String
    let cityName: String
    let coordinates: [Double]
    let description: String
    let logoUrl: String
    let phone: String
    let link: String
}
