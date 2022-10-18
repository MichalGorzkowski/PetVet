//
//  AntiParasiteListView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI

struct AntiParasitesListView: View {
    @State private var showNewAntiParasiteView = false
    @State private var isListUpToDate = false
    @ObservedObject var viewModel = AntiParasitesViewModel()
    @ObservedObject var infoViewModel = DetailedInformationViewModel()

    var body: some View {
        ExecuteCode {
            if showNewAntiParasiteView == false {
                viewModel.fetchUserAntiParasites()
                infoViewModel.getPetData()
            }
        }
        
        ZStack(alignment: .bottomTrailing) {
            if infoViewModel.activePet != nil {
                VStack {
                    SmallHeaderView(title: "\(infoViewModel.activePet!.name) - Medykamenty")
                    
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.antiParasites) { antiParasite in
                                AntiParasiteRowView(antiParasite: antiParasite)
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
                    viewModel.fetchUserAntiParasites()
                    infoViewModel.getPetData()
                    isListUpToDate = false
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
                        showNewAntiParasiteView.toggle()
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
                    .fullScreenCover(isPresented: $showNewAntiParasiteView) {
                        NewAntiParasiteView()
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear() {
            print("DEBUG: AntiParasitesListView onAppear")
            viewModel.fetchUserAntiParasites()
            infoViewModel.getPetData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                infoViewModel.getPetData()
            }
        }
        //.navigationTitle("Anti-Parasites")
    }
}

struct AntiParasiteListView_Previews: PreviewProvider {
    static var previews: some View {
        AntiParasitesListView()
    }
}
