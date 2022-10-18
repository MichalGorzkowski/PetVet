//
//  ClinicsView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 02/06/2022.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct ClinicsView: View {
    @EnvironmentObject private var viewModel: ClinicsViewModel
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                mapLayer
                    .tint(.pink)
                
                VStack {
                    SmallHeaderView(title: "Lecznice w okolicy")
                    
                    Spacer()
                }
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    clinicsPreviewStack
                }
                
                if viewModel.currentClinic == nil {
                    locationButton(bottomPadding: 50)
                } else {
                    locationButton(bottomPadding: 180)
                }
            }
            .sheet(item: $viewModel.sheetClinic, onDismiss: nil) { clinic in
                ClinicDetailView(clinic: clinic)
            }
            
            Rectangle()
                .fill(.white)
                .frame(height: 8)
        }
    }
}

struct ClinicsView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicsView()
    }
}

extension ClinicsView {
    private func locationButton(bottomPadding: CGFloat) -> some View {
        LocationButton(.currentLocation) {
            viewModel.requestAllowOnceLocationPermission()
        }
        .foregroundColor(.white)
        .cornerRadius(8)
        .labelStyle(.iconOnly)
        .symbolVariant(.fill)
        .tint(Color(.systemBlue))
        .padding(.bottom, bottomPadding)
        .padding(.trailing)
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $viewModel.region,
            showsUserLocation: true,
            annotationItems: viewModel.clinics) { clinic in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: clinic.coordinates[0],
                                                             longitude: clinic.coordinates[1])) {
                ClinicMapAnnotation()
                    .scaleEffect(viewModel.currentClinic == clinic ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        viewModel.updateRegion(clinic: clinic)
                    }
            }
        }
            .onTapGesture {
                viewModel.currentClinic = nil
            }
    }
    
    private var clinicsPreviewStack: some View {
        ZStack {
            ForEach(viewModel.clinics) { clinic in
                if viewModel.currentClinic == clinic {
                    ClinicPreviewView(clinic: clinic)
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 20)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}
