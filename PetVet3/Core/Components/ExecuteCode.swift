//
//  ExecuteCode.swift
//  PetVet3
//
//  Created by Michał Gorzkowski on 13/05/2022.
//

import Foundation
import SwiftUI

struct ExecuteCode : View {
    init( _ codeToExec: () -> () ) {
            codeToExec()
        }
        
        var body: some View {
            return EmptyView()
        }
}
