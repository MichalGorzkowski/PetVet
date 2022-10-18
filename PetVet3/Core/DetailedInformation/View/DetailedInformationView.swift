//
//  DetailedInformationView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI

struct DetailedInformationView: View {
    @ObservedObject var viewModel = DetailedInformationViewModel()
    
    var body: some View {
        ExecuteCode {
            viewModel.getPetData()
        }
        
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                if viewModel.activePet != nil {
                    SmallHeaderView(title: "\(viewModel.activePet!.name)")
                    
                    VStack {
                        HStack(spacing: 4) {
                            VStack(spacing: 10) {
                                Text(viewModel.activePet!.breed)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(.darkGray))
                                Image(systemName: "pawprint")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundColor(Color(.systemBlue))
                            }
                            .frame(width: 130, height: 130)
                            
                            VStack(spacing: 10) {
                                Text("\(String(format: "%.1f", viewModel.activePet!.weight)) kg")
                                    .font(.headline)
                                    .foregroundColor(Color(.darkGray))
                                Image(systemName: "scalemass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundColor(Color(.systemBlue))

                            }
                            .frame(width: 130, height: 130)
                            
                            VStack(spacing: 10) {
                                Text(viewModel.activePet!.dateOfBirth)
                                    .font(.headline)
                                    .foregroundColor(Color(.darkGray))
                                Image(systemName: "calendar")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundColor(Color(.systemBlue))

                            }
                            .frame(width: 130, height: 130)
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 8)
                        .padding(.bottom, 40)

                        HStack(spacing: 4) {
                            VStack(spacing: 10) {
                                Text(viewModel.activePet!.color)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(.darkGray))
                                Image(systemName: "eyedropper.halffull")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundColor(Color(.systemBlue))

                            }
                            .frame(width: 130, height: 130)
                            
                            VStack(spacing: 10) {
                                Text(viewModel.activePet!.microchipNumber)
                                    .font(.headline)
                                    .foregroundColor(Color(.darkGray))
                                Image(systemName: "number")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundColor(Color(.systemBlue))

                            }
                            .frame(width: 130, height: 130)
                            
                            VStack(spacing: 10) {
                                Text(viewModel.activePet!.sex)
                                    .font(.headline)
                                    .foregroundColor(Color(.darkGray))
                                Image("genderIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundColor(Color(.systemBlue))
                            }
                            .frame(width: 130, height: 130)
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 8)
                        .padding(.bottom, 40)
                    }
                    .padding(.top, 20)
                } else {
                    SmallHeaderView(title: "Brak wybranego zwierzęcia")
                    
                    Text("Aby dodać lub wybrać zwierzę otwórz menu i następnie wybierz zwierzę.")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    
                    Spacer()
                }
            }
            .disabled(true)
                
            Button {
                viewModel.getPetData()
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 35, height: 28)
                    .padding()
            }
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding(.horizontal)
            .padding(.bottom)
        }
        //.navigationTitle("Detail")
        .edgesIgnoringSafeArea(.top)
        .onAppear() {
            print("DEBUG: DetailedInformationView onAppear")
            viewModel.getPetData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                viewModel.getPetData()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                viewModel.getPetData()
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedInformationView()
    }
}
