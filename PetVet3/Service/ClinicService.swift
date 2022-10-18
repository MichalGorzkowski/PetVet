//
//  ClinicService.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 02/06/2022.
//

import Foundation
import Firebase
import MapKit

struct ClinicService {
    func fetchClinics(completion: @escaping([Clinic]) -> Void) {
        Firestore.firestore().collection("clinics")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let clinics = documents.compactMap({ try? $0.data(as: Clinic.self) })
                completion(clinics)
            }
    }
}
