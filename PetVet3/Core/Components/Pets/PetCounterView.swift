//
//  PetCounterView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI

struct PetCounterView: View {
    @ObservedObject var changePetViewModel = ChangePetViewModel()
    @ObservedObject var viewModel = PetCounterViewModel()
    
    var body: some View {
//        ExecuteCode {
//            changePetViewModel.fetchUserPets()
//            if changePetViewModel.pets.count == 1 {
//                print("DEBUG: 1 pet counted")
//            } else if changePetViewModel.pets.count < 5 {
//                print("DEBUG: 2-4 pets counted")
//                viewModel.moreThanOne()
//            } else {
//                print("DEBUG: 5 or more pets counted")
//                viewModel.moreThanFour()
//            }
//        }
        
        HStack(spacing: 5) {
            Text("Zwierząt")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("\(changePetViewModel.pets.count)")
                .font(.subheadline).bold()
                .foregroundColor(.black)
        }
    }
}

struct PetCounterView_Previews: PreviewProvider {
    static var previews: some View {
        PetCounterView()
    }
}
