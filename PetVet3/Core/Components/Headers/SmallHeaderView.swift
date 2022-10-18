//
//  OneLineHeaderView.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 26/04/2022.
//

import SwiftUI

struct SmallHeaderView: View {
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack { Spacer() }
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .frame(height: 220)
        .padding(.leading)
        .background(Color(.systemBlue))
        .foregroundColor(.white )
        .clipShape(RoundedShape(corners: [.bottomRight], radius: 80))
    }
}

struct OneLineHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SmallHeaderView(title: "Adding a pill")
    }
}
