//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Sivaram Yadav on 11/23/21.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
