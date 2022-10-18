//
//  AntiParasiteRowViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 13/05/2022.
//

import Foundation

class AntiParasiteRowViewModel: ObservableObject {
    let antiParasite: AntiParasite
    private let service = AntiParasiteService()
    
    init(antiParasite: AntiParasite) {
        self.antiParasite = antiParasite
    }
    
    func deleteAntiParasite() {
        service.deleteAntiParasite(antiParasite)
    }
}
