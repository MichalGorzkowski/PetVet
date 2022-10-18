//
//  PetVet3App.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI
import Firebase

@main
struct PetVet3App: App {
    
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var clinicsViewModel = ClinicsViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .navigationBarTitle("Try it!", displayMode: .inline)
                    .background(NavigationConfigurator { nc in
                        nc.navigationBar.barTintColor = .blue
                        nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
                    })
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(authViewModel)
            .environmentObject(clinicsViewModel)
        }
    }
}
