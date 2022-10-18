//
//  MedicalRecordRowView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 03/05/2022.
//

import SwiftUI

struct MedicalRecordRowView: View {
    let viewModel: MedicalRecordRowViewModel
    
    init(medicalRecord: MedicalRecord) {
        self.viewModel = MedicalRecordRowViewModel(medicalRecord: medicalRecord)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack { Spacer() }
                    
                    HStack {
                        Text(viewModel.medicalRecord.date)
                            .font(.subheadline).bold()
                        
                        Text(viewModel.medicalRecord.name)
                            .font(.subheadline).bold()
                    }

                    Text(viewModel.medicalRecord.description)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    
                    Text(viewModel.medicalRecord.doctorsRecomendations)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
                                
                Button {
                    viewModel.deleteMedicalRecord()
                } label: {
                    Image(systemName: "trash")
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

//struct MedicalRecordRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicalRecordRowView()
//    }
//}
