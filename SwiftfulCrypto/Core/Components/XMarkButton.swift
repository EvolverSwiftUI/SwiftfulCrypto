//
//  XMarkButton.swift
//  SwiftfulCrypto
//
//  Created by Sivaram Yadav on 11/27/21.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
