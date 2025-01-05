//
//  AppState.swift
//  AIChat
//
//  Created by Artem Panasenko on 05.01.2025.
//

import Foundation

@Observable
class AppState {
    
    /// ShowTabBar state
    private(set) var showTabBar: Bool {
        didSet {
            UserDefaults.showTabbarView = showTabBar
        }
    }
    
    init(showTabBar: Bool = UserDefaults.showTabbarView) {
        self.showTabBar = showTabBar
    }
    
    /// Update `showTabBarView` property  for self
    /// - Parameter showTabBarView: as `Bool`
    func updateViewState(showTabBarView: Bool) {
        showTabBar = showTabBarView
    }
}
 
