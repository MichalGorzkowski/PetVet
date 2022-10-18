//
//  ClinicsViewModel.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 02/06/2022.
//

import Foundation
import MapKit
import CoreLocationUI
import SwiftUI

final class ClinicsViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var clinics: [Clinic] = []
    private let service = ClinicService()
    
    @Published var sheetClinic: Clinic? = nil
    
    @Published var currentClinic: Clinic?
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.237049, longitude: 21.017532),
                                               span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        self.fetchClinics()
    }
    
    func requestAllowOnceLocationPermission() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            // show an error
            return
        }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: latestLocation.coordinate,
                                             span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func updateRegion(clinic: Clinic) {
        withAnimation(.easeInOut) {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: clinic.coordinates[0], longitude: clinic.coordinates[1]),
                                        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            currentClinic = clinic
        }
    }
    
    func fetchClinics() {
        service.fetchClinics { clinics in
            self.clinics = clinics
        }
    }
}
