//
//  ChangePetListView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 03/05/2022.
//

import SwiftUI

struct ChangePetListView: View {
    @State private var showNewPetView = false
    @State private var selectedFilter: PetFilterViewModel = .all
    @Namespace var animation
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = ChangePetViewModel()
        
    var body: some View {
        ExecuteCode {
            if showNewPetView == false {
                viewModel.fetchUserPets()
            }
        }
        
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                SmallHeaderView(title: "Wybierz zwierzę")
                    .ignoresSafeArea()
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 20, y: 12)
                }
            }
            .padding(.bottom, -30)
            
            //petFilterBar
            
            petsList
            
            Spacer()
        }
        .onAppear() {
            viewModel.fetchUserPets()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                viewModel.fetchUserPets()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                viewModel.fetchUserPets()
            }
        }
        .navigationBarHidden(true)
    }
}

struct ChangePetListView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePetListView()
    }
}

extension ChangePetListView {
    var petFilterBar: some View {
        HStack {
            ForEach(PetFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
    
    var petsList: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.pets) { pet in
                        ChangePetRowView(pet: pet)
                            .padding()
                        Divider()
                    }
                }
            }
            
            VStack (alignment: .center){
                Button {
                    viewModel.fetchUserPets()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 12, height: 12)
                        .padding()
                }
                .background(.gray)
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding(.horizontal)
                .padding(.top)
                
                Button {
                    showNewPetView.toggle()
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
                .fullScreenCover(isPresented: $showNewPetView) {
                    NewPetView()
                }
            }
        }
    }
}
