//
//  ClinicMapAnnotation.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 03/06/2022.
//

import SwiftUI

struct ClinicMapAnnotation: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "pawprint.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding(6)
                .background(Color(.systemBlue))
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(.systemBlue))
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 37)
        }
    }
}

struct ClinicMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicMapAnnotation()
    }
}
