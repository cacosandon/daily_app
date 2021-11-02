//
//  InfoCard.swift
//  Dailys
//
//  Created by Caco Ossandon on 01-11-21.
//  Copyright © 2021 Apple. All rights reserved.
//

import SwiftUI

struct ErrorCard: View {
    var name: String
    var error: String

    var body: some View {
        VStack {
            Text(name)
                .font(.title)
                .fontWeight(.medium)
                .padding(.bottom, 5)
            Text(error)
        }
        .frame(width: 200, height: 100)
        .padding(25)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}
    
struct ErrorCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ErrorCard(name: "Dólar", error: "Ocurrió un error")
        }
    }
}
