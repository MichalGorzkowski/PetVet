////
////  ProfileView.swift
////  PetVet3
////
////  Created by Michał Gorzkowski on 24/04/2022.
////
//
//import SwiftUI
//import Kingfisher
//
//struct ProfileView: View {
//    @State private var selectedFilter: PetFilterViewModel = .all
//    @Namespace var animation
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    private let user: User
//    
//    init(user: User) {
//        self.user = user
//    }
//        
//    var body: some View {
//        VStack(alignment: .leading) {
//            headerView
//            
//            actionButtons
//            
//            userInfo
//            
//            userDetails
//            
//            petFilterBar
//            
//            petsList
//            
//            Spacer()
//        }
//        .navigationBarHidden(true)
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(user: User(id: NSUUID().uuidString,
//                               username: "batman",
//                               fullname: "Bruce Wayne",
//                               profileImageUrl: "",
//                               email: "batman@gmail.com"))
//    }
//}
//
//extension ProfileView {
//    var headerView: some View {
//        ZStack(alignment: .bottomLeading) {
//            Color(.systemBlue)
//                .ignoresSafeArea()
//            
//            VStack {
//                Button {
//                    self.presentationMode.wrappedValue.dismiss()
//                } label: {
//                    Image(systemName: "arrow.left")
//                        .resizable()
//                        .frame(width: 20, height: 16)
//                        .foregroundColor(.white)
//                        .offset(x: 16, y: 12)
//                }
//                
//                KFImage(URL(string: user.profileImageUrl))
//                    .resizable()
//                    .scaledToFill()
//                    .clipShape(Circle())
//                    .frame(width: 72, height: 72)
//                    .offset(x: 16, y: 24)
//            }
//        }
//        .frame(height: 96)
//    }
//    
//    var actionButtons: some View {
//        HStack(spacing: 12) {
//            Spacer()
//            
//            Image(systemName: "bell.badge")
//                .font(.title3)
//                .padding(6)
//                .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
//            
//            Button {
//                // action here
//            } label: {
//                Text("Edit Profile")
//                    .font(.subheadline).bold()
//                    .frame(width: 120, height: 32)
//                    .foregroundColor(.black)
//                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
//            }
//
//        }
//        .padding(.trailing)
//    }
//    
//    var userInfo: some View {
//        VStack(alignment: .leading, spacing: 4) {
//            HStack {
//                Text(user.fullname)
//                    .font(.title2).bold()
//                
//                Image(systemName: "checkmark.seal.fill")
//                    .foregroundColor(Color(.systemBlue))
//            }
//            
//            HStack(spacing: 20) {
//                Text("@\(user.username)")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                
//                PetCounterView()
//            }
//        }
//        .padding(.horizontal)
//    }
//    
//    var userDetails: some View {
//        VStack(alignment: .leading, spacing: 4) {
//            HStack(alignment: .center) {
//                Image(systemName: "mappin.and.ellipse")
//                    .font(.subheadline)
//                
//                Text("Address ")
//                    .font(.subheadline).bold()
//                    .frame(width: 125, alignment: .leading)
//                
//                Text("ul. Mozarta 10/317, 02-736 Warszawa, Polska")
//                    .font(.subheadline)
//                    .multilineTextAlignment(.leading)
//                    .padding(.horizontal)
//            }
//            .padding(.vertical)
//            
//            HStack(alignment: .center) {
//                Image(systemName: "phone")
//                    .font(.subheadline)
//                
//                Text("Phone number ")
//                    .font(.subheadline).bold()
//                    .frame(width: 125, alignment: .leading)
//                
//                Text("+48 792 956 632")
//                    .font(.subheadline)
//                    .multilineTextAlignment(.leading)
//                    .padding(.horizontal)
//            }
//            .padding(.vertical)
//            
//            HStack(alignment: .center) {
//                Image(systemName: "envelope")
//                    .font(.subheadline)
//                
//                Text("Email address ")
//                    .font(.subheadline).bold()
//                    .frame(width: 125, alignment: .leading)
//                
//                Text(verbatim: "s22006@pjwstk.edu.pl")
//                    .font(.subheadline)
//                    .multilineTextAlignment(.leading)
//                    .padding(.horizontal)
//            }
//            .padding(.vertical)
//        }
//        .padding(.horizontal)
//    }
//    
//    var petFilterBar: some View {
//        HStack {
//            ForEach(PetFilterViewModel.allCases, id: \.rawValue) { item in
//                VStack {
//                    Text(item.title)
//                        .font(.subheadline)
//                        .fontWeight(selectedFilter == item ? .semibold : .regular)
//                        .foregroundColor(selectedFilter == item ? .black : .gray)
//                    
//                    if selectedFilter == item {
//                        Capsule()
//                            .foregroundColor(Color(.systemBlue))
//                            .frame(height: 3)
//                            .matchedGeometryEffect(id: "filter", in: animation)
//                    } else {
//                        Capsule()
//                            .foregroundColor(Color(.clear))
//                            .frame(height: 3)
//                    }
//                }
//                .onTapGesture {
//                    withAnimation(.easeInOut) {
//                        self.selectedFilter = item
//                    }
//                }
//            }
//        }
//        .overlay(Divider().offset(x: 0, y: 16))
//    }
//    
//    var petsList: some View {
//        ScrollView {
//            LazyVStack {
//                ForEach(0 ... 10, id: \.self) { _ in
//                    PetRowView(iconName: "square.and.pencil")
//                        .padding()
//                    Divider()
//                }
//            }
//        }
//    }
//}
