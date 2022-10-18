//
//  RoundedShape.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 24/04/2022.
//

import SwiftUI

struct RoundedShape: Shape {
    var corners: UIRectCorner
    var radius: Int
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
