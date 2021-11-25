//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Sivaram Yadav on 11/23/21.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
