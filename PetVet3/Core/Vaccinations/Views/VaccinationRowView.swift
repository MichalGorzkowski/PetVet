//
//  VaccinationRowView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI

struct VaccinationRowView: View {
    let viewModel: VaccinationRowViewModel
    
    init(vaccination: Vaccination) {
        self.viewModel = VaccinationRowViewModel(vaccination: vaccination)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack { Spacer() }
                    
                    HStack {
                        Text(viewModel.vaccination.medicineName)
                            .font(.subheadline).bold()
                        
                        Text("SER: \(viewModel.vaccination.lot)")
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        Text("WAŻ: \(viewModel.vaccination.expirationDate)")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    
                    Text(viewModel.vaccination.applicationDate)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    
                    Text(viewModel.vaccination.comment)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
                
                Button {
                    viewModel.deleteVaccination()
                } label: {
                    Image(systemName: "trash")
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

//struct VaccinationRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        VaccinationRowView()
//    }
//}
