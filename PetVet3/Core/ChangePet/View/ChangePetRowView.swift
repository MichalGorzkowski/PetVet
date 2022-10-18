//
//  ChangePetRowView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 03/05/2022.
//

import SwiftUI

struct ChangePetRowView: View {
    let viewModel: ChangePetRowViewModel
    @State var isDeleteAlertPresented = false
    @State var isSetActiveAlertPresented = false
    
    init(pet: Pet) {
        self.viewModel = ChangePetRowViewModel(pet: pet)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // vaccination icon + vaccination info + dates + action buttons
            HStack(spacing: 12) {
                
                Button {
                    isSetActiveAlertPresented = true
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        
                        // full width
                        HStack { Spacer() }
                        
                        // vaccination info
                        HStack {
                            Text(viewModel.pet.name)
                                .font(.subheadline).bold()
                            
                            Text(viewModel.pet.breed)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Text(viewModel.pet.dateOfBirth)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                }
                .alert("Zmieniono aktywne zwierzę.", isPresented: $isSetActiveAlertPresented) {
                    Button(role: .cancel) {
                        viewModel.setActive()
                    } label: {
                        Text("OK")
                    }
                } message: {
                    Text("Od teraz Twoim aktywnym zwierzęciem jest \(viewModel.pet.name).")
                }
                                
                // action buttons
                HStack(spacing: 13) {
                    Button {
                        isDeleteAlertPresented = true
                    } label: {
                        Image(systemName: "trash")
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }
                    .alert("Czy naprwno chcesz usunąć zwierzę \(viewModel.pet.name)?", isPresented: $isDeleteAlertPresented) {
                        Button(role: .cancel) {
                            // no delete - nothing to do here
                        } label: {
                            Text("Wróć")
                        }
                        
                        Button(role: .destructive) {
                            viewModel.delete()
                        } label: {
                            Text("Usuń")
                        }
                    } message: {
                        Text("Usunięcie zwierzęcia spowoduje skasowanie wszystkich danych, które go dotyczą.")
                    }
                }
            }
        }
    }
}

//struct ChangePetRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChangePetRowView()
//    }
//}
