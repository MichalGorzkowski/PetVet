//
//  AntiParasiteRowView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI

struct AntiParasiteRowView: View {
    let viewModel: AntiParasiteRowViewModel
    
    init(antiParasite: AntiParasite) {
        self.viewModel = AntiParasiteRowViewModel(antiParasite: antiParasite)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack { Spacer() }
                    
                    HStack {
                        Text(viewModel.antiParasite.medicineName)
                            .font(.subheadline).bold()
                        
                        Text(viewModel.antiParasite.lot)
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        Text(viewModel.antiParasite.expirationDate)
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    
                    Text(viewModel.antiParasite.applicationDate)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    
                    Text(viewModel.antiParasite.comment)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
                
                Button {
                    viewModel.deleteAntiParasite()
                } label: {
                    Image(systemName: "trash")
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

//struct AntiParasiteRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        AntiParasiteRowView()
//    }
//}
