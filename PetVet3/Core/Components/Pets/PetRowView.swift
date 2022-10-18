////
////  PetRowView.swift
////  PetVet3
////
////  Created by Michał Gorzkowski on 24/04/2022.
////
//
//import SwiftUI
//
//struct PetRowView: View {
//    @State var iconName: String
//    var body: some View {
//        VStack(alignment: .leading) {
//
//            // pet photo + pet info + details + action buttons
//            HStack(spacing: 12) {
//
//                // pet photo
//                Circle()
//                    .frame(width: 62, height: 62)
//                    .foregroundColor(Color(.systemBlue))
//
//                // pet info + details
//                VStack(alignment: .leading, spacing: 4) {
//
//                    // full width
//                    HStack { Spacer() }
//
//                    VStack(alignment: .leading) {
//                        Text("Benny")
//                            .font(.title3).bold()
//
//                        HStack(spacing: 15) {
//                            Text("Husky")
//                                .foregroundColor(.gray)
//                                .font(.subheadline)
//
//                            Text("2 years")
//                                .foregroundColor(.gray)
//                                .font(.subheadline)
//                        }
//                    }
//                }
//
//                // action buttons
//                HStack(spacing: 13) {
//                    Button {
//                        // action goes here...
//                    } label: {
//                        Image(systemName: iconName)
//                            .font(.subheadline)
//                    }
//
//                    Button {
//                        // action goes here...
//                    } label: {
//                        Image(systemName: "trash")
//                            .font(.subheadline)
//                            .foregroundColor(.red)
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct PetRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PetRowView(iconName: "check.circle.fill")
//    }
//}
