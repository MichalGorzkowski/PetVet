//
//  ContentView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @State private var showMenu = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                // no user logged in
                LoginView()
                //TestView()
            } else {
                // have a logged in user
                mainInterfaceView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    var mainInterfaceView: some View {
        ZStack(alignment: .topLeading) {
            MainTabView()
                .navigationBarHidden(showMenu)
            
            if showMenu {
                ZStack {
                    Color(.black)
                        .opacity(showMenu ? 0.25 : 0.0)
                }.onTapGesture {
                    withAnimation(.easeInOut) {
                        showMenu = false
                    }
                }
                .ignoresSafeArea()
            }
            
            SideMenuView()
                .frame(width: 300)
                .offset(x: showMenu ? 0 : -300, y: 0)
                .background(showMenu ? Color.white : Color.clear)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
//                if let user = viewModel.currentUser {
//                    Button {
//                        withAnimation(.easeInOut) {
//                            showMenu.toggle()
//                        }
//                    } label: {
//                        KFImage(URL(string: user.profileImageUrl))
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 32, height: 32)
//                            .clipShape(Circle())
//                    }
//                }
                Button {
                    withAnimation(.easeInOut) {
                        showMenu.toggle()
                    }
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .frame(width: 25)
                        .foregroundColor(.white)
                }

            }
        }
        .onAppear {
            showMenu = false
        }
    }
}
