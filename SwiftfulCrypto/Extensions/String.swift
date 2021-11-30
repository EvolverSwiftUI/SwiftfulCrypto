//
//  String.swift
//  SwiftfulCrypto
//
//  Created by Sivaram Yadav on 11/30/21.
//

import Foundation

extension String {
    
    var removeHTMLOccurances: String {
        
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
