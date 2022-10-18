//
//  UploadPetViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 07/05/2022.
//

import Foundation

class UploadPetViewModel: ObservableObject {
    @Published var name = ""
    @Published var microchipNumber = ""
    @Published var dateOfBirth = Date()
    @Published var breed = ""
    @Published var color = ""
    @Published var sex = ""
    @Published var weight = 0.0
    @Published var didUploadPet = false
    @Published var date1950: Date = Calendar.current.date(from: DateComponents(year: 1950)) ?? Date()
    @Published var today: Date = Date()
    let service = PetService()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "pl-PL")
        return formatter
    }
    
    func uploadPet(name: String,
                   dateOfBirth: Date,
                   breed: String,
                   color: String,
                   microchipNumber: String,
                   sex: String,
                   weight: Double) {
        service.uploadPet(name: name,
                          dateOfBirth: dateFormatter.string(from: dateOfBirth),
                          breed: breed,
                          color: color,
                          microchipNumber: microchipNumber,
                          sex: sex,
                          weight: weight) { success in
            if success {
                self.didUploadPet = true
            } else {
                // show error message to user
            }
        }
    }
    
//    func uploadDemoPet() {
//        service.uploadPet(name: "Benny",
//                          dateOfBirth: "03.12.2019",
//                          breed: "Husky",
//                          color: "gray",
//                          microchipNumber: "A73BCK882CC",
//                          sex: "Male",
//                          weight: 10.5) { success in
//            if success {
//                self.didUploadPet = true
//            } else {
//                // show error message to user
//            }
//        }
//    }
    
    // VALIDATION
    
    func isMicrochipNumberValid() -> Bool {
        let microchipNumberTest = NSPredicate(format: "SELF MATCHES %@",
        "^[a-zA-Z0-9]+$") // letters and numbers only
        return microchipNumberTest.evaluate(with: microchipNumber)
    }
    
    func isBreedValid() -> Bool {
        let breedTest = NSPredicate(format: "SELF MATCHES %@",
        "^[a-zA-Z]+$") //letters only
        return breedTest.evaluate(with: breed)
    }
    
    func isColorValid() -> Bool {
        let colorTest = NSPredicate(format: "SELF MATCHES %@",
        "^[a-zA-Z]+$") //letters only
        return colorTest.evaluate(with: color)
    }
    
    func isSexValid() -> Bool {
        if sex == "Samiec" || sex == "Samica" { return true }
        else { return false }
    }
    
//    func isWeightValid() -> Bool {
//        let weightTest = NSPredicate(format: "SELF MATCHES %@",
//        "^\\d*\\.?\\d*$") // numbers only
//        return weightTest.evaluate(with: weight)
//    }
    
    var isFormComplete: Bool {
        if !isMicrochipNumberValid() ||
           !isBreedValid() ||
           !isColorValid() ||
           !isSexValid()
        {
            return false
        }
        return true
    }
    
    // VALIDATION PROMPT STRINGS
    
    var microchipNumberPrompt: String {
        if isMicrochipNumberValid() {
            return ""
        } else {
            return "Może składać się tylko z liter i cyfr"
        }
    }
    
    var breedPrompt: String {
        if isBreedValid() {
            return ""
        } else {
            return "Musi składać się tylko z liter"
        }
    }
    
    var colorPrompt: String {
        if isColorValid() {
            return ""
        } else {
            return "Musi składać się tylko z liter"
        }
    }
    
//    var weightPrompt: String {
//        if isWeightValid() {
//            return ""
//        } else {
//            return "Must be numbers with dot only"
//        }
//    }
    
    func cleanAfterSignUp() {
        name = ""
        microchipNumber = ""
        dateOfBirth = Date()
        breed = ""
        color = ""
        sex = ""
        weight = 0.0
    }
}
