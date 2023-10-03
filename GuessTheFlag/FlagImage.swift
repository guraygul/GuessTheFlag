//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Güray Gül on 28.09.2023.
//

import SwiftUI

struct FlagImage: View {
    
    let name: String
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

#Preview {
    FlagImage(name: "UK")
}
