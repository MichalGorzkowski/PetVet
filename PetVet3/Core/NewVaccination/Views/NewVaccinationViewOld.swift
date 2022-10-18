//
//  NewVaccinationViewOld.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 26/04/2022.
//

import SwiftUI
import Kingfisher

struct NewVaccinationViewOld: View {
    @State private var caption = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = UploadVaccinationOldViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    viewModel.uploadVaccination(withCaption: caption)
                } label: {
                    Text("Add")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding()
            
            HStack(alignment: .top) {
                if let user = authViewModel.currentUser {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                }
                
                TextArea("Vaccination Name", text: $caption)
            }
            .padding()
        }
        .onReceive(viewModel.$didUploadVaccination) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct NewVaccinationViewOld_Previews: PreviewProvider {
    static var previews: some View {
        NewVaccinationViewOld()
    }
}
