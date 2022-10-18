//
//  SideMenuViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable {
    case profile
    case pets
    case logout
    
    var title: String {
        switch self {
        case .profile: return "Profil"
        case .pets: return "Wybierz zwierzę"
        case .logout: return "Wyloguj się"
        }
    }
    
    var imageName: String{
        switch self {
        case .profile: return "person"
        case .pets: return "pawprint"
        case .logout: return "rectangle.portrait.and.arrow.right"
        }
    }
}
