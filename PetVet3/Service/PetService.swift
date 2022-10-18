//
//  PetService.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/05/2022.
//

import Firebase

struct PetService {
    func uploadPet(name: String,
                   dateOfBirth: String,
                   breed: String,
                   color: String,
                   microchipNumber: String,
                   sex: String,
                   weight: Double,
                   completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "name": name,
                    "dateOfBirth": dateOfBirth,
                    "breed": breed,
                    "color": color,
                    "microchipNumber": microchipNumber,
                    "sex": sex,
                    "weight": weight,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("pets").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload pet with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                print("DEBUG: uploadPet func pet uploaded")
                
                completion(true)
            }
        
        print("DEBUG: uploadPet func done")
    }
    
    func fetchPets(completion: @escaping([Pet]) -> Void) {
        Firestore.firestore().collection("pets")
            .order(by: "name", descending: false)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let pets = documents.compactMap({ try? $0.data(as: Pet.self) })
                completion(pets)
            }
    }
    
    func fetchPets(forUid uid: String, completion: @escaping([Pet]) -> Void) {
        Firestore.firestore().collection("pets")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let pets = documents.compactMap({ try? $0.data(as: Pet.self) })
                completion(pets.sorted(by: { $0.name > $1.name }))
            }
    }
    
    func setActive(_ pet: Pet) {
        guard let uid =  Auth.auth().currentUser?.uid else { return }
        guard let petId = pet.id else { return }
        
        Firestore.firestore().collection("users").document(uid).updateData(["currentPet": petId]) { _ in
            print("DEBUG: setActivePet func done")
        }
    }
    
    func deletePet(_ pet: Pet) {
        guard let petId = pet.id else { return }
        
        Firestore.firestore().collection("pets").document(petId).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func getActivePetData(forPetId petId: String, completion: @escaping(Pet) -> Void) {
        Firestore.firestore().collection("pets")
            .document(petId)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let pet = try? snapshot.data(as: Pet.self) else { return }
                completion(pet)
            }
    }
}
