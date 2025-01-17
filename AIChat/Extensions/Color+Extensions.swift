//
//  Color+Extensions.swift
//  AIChat
//
//  Created by Artem Panasenko on 17.01.2025.
//

import SwiftUI

extension Color {
    /// Initializes a `Color` from a hex string.
    /// - Parameter hex: A hexadecimal color string (e.g., "#RRGGBB" or "RRGGBB").
    init?(hex: String) {
        // Remove `#` if present
        let sanitizedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        guard sanitizedHex.count == 6 else {
            return nil
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: sanitizedHex).scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }

    /// Converts a `Color` to a hexadecimal string.
    /// - Returns: A hex string in the format "#RRGGBB" if conversion succeeds, otherwise `nil`.
    func toHex() -> String? {
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let red = Int(components[0] * 255)
        let green = Int(components[1] * 255)
        let blue = Int(components[2] * 255)
        
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
}

