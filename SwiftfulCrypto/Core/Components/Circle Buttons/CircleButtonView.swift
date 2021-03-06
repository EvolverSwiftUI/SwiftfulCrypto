//
//  CirclebuttonView.swift
//  SwiftfulCrypto
//
//  Created by Sivaram Yadav on 11/23/21.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10,
                x: 0, y: 0
            )
            .padding()
    }
}

struct CirclebuttonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "info")
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)

            CircleButtonView(iconName: "plus")
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
