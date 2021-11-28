//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by Sivaram Yadav on 11/28/21.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
