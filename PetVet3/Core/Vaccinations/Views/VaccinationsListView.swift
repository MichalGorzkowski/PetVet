//
//  VaccinationsView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI

struct VaccinationsListView: View {
    @State private var showNewVaccinationView = false
    @ObservedObject var viewModel = VaccinationsViewModel()
    @ObservedObject var uploadViewModel = UploadVaccinationViewModel()
    @ObservedObject var infoViewModel = DetailedInformationViewModel()
    
    var body: some View {
        ExecuteCode {
            if showNewVaccinationView == false  {
                viewModel.fetchUserVaccinations()
                infoViewModel.getPetData()
            }
        }
        
        ZStack(alignment: .bottomTrailing) {
            if infoViewModel.activePet != nil {
                VStack {
                    SmallHeaderView(title: "\(infoViewModel.activePet!.name) - Szczepienia")
                    
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.vaccinations) { vaccination in
                                VaccinationRowView(vaccination: vaccination)
                                    .padding()
                                Divider()
                            }
                        }
                    }
                }
            } else {
                VStack {
                    SmallHeaderView(title: "Brak wybranego zwierzęcia")
                    
                    Text("Aby dodać lub wybrać zwierzę otwórz menu i następnie wybierz zwierzę.")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    
                    Spacer()
                }
            }
            
            VStack (alignment: .center){
                Button {
                    viewModel.fetchUserVaccinations()
                    infoViewModel.getPetData()
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 15, height: 12)
                        .padding()
                }
                .background(.gray)
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding(.horizontal)
                .padding(.top)
                
                if infoViewModel.activePet != nil {
                    Button {
                        showNewVaccinationView.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 28, height: 28)
                            .padding()
                    }
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding(.horizontal)
                    .padding(.bottom)
                    .fullScreenCover(isPresented: $showNewVaccinationView) {
                        NewVaccinationView()
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear() {
            print("DEBUG: VaccinationListView onAppear")
            viewModel.fetchUserVaccinations()
            infoViewModel.getPetData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                infoViewModel.getPetData()
            }
            
        }
        //.navigationTitle("Vaccinations")
    }
}

struct VaccinationsListView_Previews: PreviewProvider {
    static var previews: some View {
        VaccinationsListView()
    }
}
