//
//  AuthenticationHeaderView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 26/04/2022.
//

import SwiftUI

struct TwoLineHeaderView: View {
    let titleFirst: String
    let titleSecond: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack { Spacer() }
            
            Text(titleFirst)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(titleSecond)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .frame(height: 260)
        .padding(.leading)
        .background(Color(.systemBlue))
        .foregroundColor(.white )
        .clipShape(RoundedShape(corners: [.bottomRight], radius: 80))
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TwoLineHeaderView(titleFirst: "Hello.", titleSecond: "Welcome back.")
    }
}
