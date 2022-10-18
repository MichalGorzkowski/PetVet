//
//  SideMenuView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var infoViewModel = DetailedInformationViewModel()
    
    var body: some View {
        if let user = authViewModel.currentUser {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 48, height: 48)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.fullname)
                            .font(.headline)
                        
                        HStack(spacing: 20) {
                            Text("@\(user.username)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            PetCounterView()
                        }
                    }
                }
                .padding(.top)
                .padding(.leading)
                
                if infoViewModel.activePet != nil {
                    HStack(spacing: 16) {
                        Text("Aktywne zwierzę")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text(infoViewModel.activePet!.name)
                            .font(.subheadline).bold()
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 26)
                }
                
                ForEach(SideMenuViewModel.allCases, id: \.rawValue) { viewModel in
                    if viewModel == .profile {
//                        NavigationLink {
//                            ProfileView(user: user)
//                        } label: {
//                            SideMenuOptionRowView(viewModel: viewModel)
//                        }
                    } else if viewModel == .pets {
                        NavigationLink {
                            ChangePetListView()
                        } label: {
                            SideMenuOptionRowView(viewModel: viewModel)
                        }
                    } else if viewModel == .logout {
                        Button {
                            authViewModel.signOut()
                        } label: {
                            SideMenuOptionRowView(viewModel: viewModel)
                        }
                    } else {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }
                }
                
                Spacer()
            }
            .onAppear() {
                infoViewModel.getPetData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    infoViewModel.getPetData()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    infoViewModel.getPetData()
                }
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
