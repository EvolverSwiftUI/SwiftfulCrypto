//
//  Color.swift
//  SwiftfulCrypto
//
//  Created by Sivaram Yadav on 11/23/21.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme2()
    static let launch = LaunchTheme()
}


struct ColorTheme {
    
    let accent          = Color("AccentColor")
    let background      = Color("BackgroundColor")
    let green           = Color("GreenColor")
    let red             = Color("RedColor")
    let secondaryText   = Color("SecondaryTextColor")
}

struct ColorTheme2 {
    
    let accent          = Color("AccentColor")
    let background      = Color("BackgroundColor")
    let green           = Color("GreenColor")
    let red             = Color("RedColor")
    let secondaryText   = Color("SecondaryTextColor")
}

// Like this we can add N number of themes to our application

struct LaunchTheme {
    
    let accent          = Color("LaunchAccentColor")
    let background      = Color("LaunchBackgroundColor")
    let green           = Color("GreenColor")
    let red             = Color("RedColor")
    let secondaryText   = Color("SecondaryTextColor")
}
