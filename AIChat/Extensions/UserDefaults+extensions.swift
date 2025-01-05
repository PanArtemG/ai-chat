//
//  UserDefaults+extensions.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import Foundation

extension UserDefaults {
    private struct Keys {
        static let showTabBarView = "showTabBarView"
    }
    
    static var showTabbarView: Bool {
        get {
            standard.bool(forKey: Keys.showTabBarView)
        } set {
            standard.set(newValue, forKey: Keys.showTabBarView)
        }
    }
}
