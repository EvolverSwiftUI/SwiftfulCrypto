//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by Sivaram Yadav on 11/26/21.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
