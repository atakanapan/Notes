//
//  CreditsView.swift
//  Notes Watch App
//
//  Created by Atakan Apan on 7/21/23.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack(spacing: 3) {
            //Profile Image
            Image("developer-no1")
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            
            //Header
            HeaderView(title: "Credits")
            
            //Content
            Text("Atakan Apan")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
            
        }//VStack
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
