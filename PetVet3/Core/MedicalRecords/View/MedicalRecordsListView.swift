//
//  MedicalRecordsView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI

struct MedicalRecordsListView: View {
    @State private var showNewMedicalRecordView = false
    @ObservedObject var viewModel = MedicalRecordsViewModel()
    @ObservedObject var uploadViewModel = UploadMedicalRecordViewModel()
    @ObservedObject var infoViewModel = DetailedInformationViewModel()

    var body: some View {
        ExecuteCode {
            if showNewMedicalRecordView == false  {
                viewModel.fetchUserMedicalRecords()
                infoViewModel.getPetData()
            }
        }
        
        ZStack(alignment: .bottomTrailing) {
            if infoViewModel.activePet != nil {
                VStack {
                    SmallHeaderView(title: "\(infoViewModel.activePet!.name) - Wizyty i zabiegi")
                    
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.medicalRecords) { medicalRecord in
                                MedicalRecordRowView(medicalRecord: medicalRecord)
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
                    viewModel.fetchUserMedicalRecords()
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
                        showNewMedicalRecordView.toggle()
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
                    .fullScreenCover(isPresented: $showNewMedicalRecordView) {
                        NewMedicalRecordView()
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear() {
            print("DEBUG: VaccinationListView onAppear")
            viewModel.fetchUserMedicalRecords()
            infoViewModel.getPetData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                infoViewModel.getPetData()
            }
            
        }
        //.navigationTitle("Medical Records")
    }
}

struct MedicalRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalRecordsListView()
    }
}
