//
//  MainTabView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 2
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            VaccinationsListView()
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "eyedropper.halffull")
                }.tag(0)
            
            AntiParasitesListView()
                .onTapGesture {
                    self.selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "pills")
                }.tag(1)
            
            DetailedInformationView()
                .onTapGesture {
                    self.selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "house")
                }.tag(2)
            
            MedicalRecordsListView()
                .onTapGesture {
                    self.selectedIndex = 3
                }
                .tabItem {
                    Image(systemName: "stethoscope")
                }.tag(3)
            
            ClinicsView()
                .onTapGesture {
                    self.selectedIndex = 4
                }
                .tabItem {
                    Image(systemName: "map")
                }.tag(4)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
