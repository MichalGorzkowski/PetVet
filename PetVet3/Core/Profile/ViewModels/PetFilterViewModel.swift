//
//  PetFilterViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import Foundation

enum PetFilterViewModel: Int, CaseIterable {
    case all
    case dogs
    case cats
    
    var title: String {
        switch self {
        case .all: return "All"
        case .dogs: return "Dogs"
        case .cats: return "Cats"
        }
    }
}
