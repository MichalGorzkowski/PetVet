//
//  ClinicPreviewView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 03/06/2022.
//

import SwiftUI
import Kingfisher

struct ClinicPreviewView: View {
    @EnvironmentObject private var viewModel: ClinicsViewModel
    
    let clinic: Clinic
    let phone = "tel://"
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack {
                learnMoreButton
                phoneButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

//struct ClinicPreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClinicPreviewView(clinic: nil)
//    }
//}

extension ClinicPreviewView {
    private var imageSection: some View {
        ZStack {
            if let image = clinic.logoUrl {
                KFImage(URL(string: image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(clinic.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(clinic.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            viewModel.sheetClinic = clinic
        } label: {
            Text("Więcej")
                .font(.headline)
                .frame(width: 125, height: 30)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var phoneButton: some View {
        Button {
            let phone = "tel://"
            let phoneNumberformatted = phone + clinic.phone
            guard let url = URL(string: phoneNumberformatted) else { return }
            UIApplication.shared.open(url)
            print("DEBUG: phone button tapped")
        } label: {
            Text("Zadzwoń")
                .font(.headline)
                .frame(width: 125, height: 30)
        }
        .buttonStyle(.bordered)
    }
}
