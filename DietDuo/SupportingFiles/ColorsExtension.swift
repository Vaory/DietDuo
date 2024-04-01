//
//  Extensions.swift
//  DietDuo
//
//  Created by Mikhail Demichev on 13.02.2024.
//

import SwiftUI

extension Color {
    
    static let customGreen = Color(hex: 0xb9c97f)
    static let customGray = Color(hex: 0xe3d3c5)
    static let customOrange = Color(hex: 0xdb8d2e)
    
    
    init(hex: UInt, alpha: Double = 0.7) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}
