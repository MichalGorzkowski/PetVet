//
//  ClinicDetailView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 03/06/2022.
//

import SwiftUI
import Kingfisher
import MapKit

struct ClinicDetailView: View {
    @EnvironmentObject private var viewModel: ClinicsViewModel
    
    let clinic: Clinic
    
    var body: some View {
        ScrollView {
            VStack {
                logoSection
                    .frame(width: UIScreen.main.bounds.width)
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)
    }
}

//struct ClinicDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClinicDetailView()
//    }
//}

extension ClinicDetailView {
    private var logoSection: some View {
        KFImage(URL(string: clinic.logoUrl))
            .resizable()
            .scaledToFill()
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(clinic.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(clinic.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(clinic.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let url = URL(string: clinic.link) {
                Link("Otwórz stronę internetową", destination: url)
                    .font(.headline)
                    .tint(Color(.systemBlue))
            }
        }
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: clinic.coordinates[0],
                                                                                          longitude: clinic.coordinates[1]),
                                                           span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))),
            showsUserLocation: true,
            annotationItems: [clinic]) { clinic in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: clinic.coordinates[0],
                                                             longitude: clinic.coordinates[1])) {
                ClinicMapAnnotation()
                    .shadow(radius: 10)
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
    }
    
    private var backButton: some View {
        Button {
            viewModel.sheetClinic = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }

    }
}
