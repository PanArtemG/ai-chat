//
//  AIChatApp.swift
//  AIChat
//
//  Created by Artem Panasenko on 04.01.2025.
//

import Firebase
import SwiftUI

@main
struct AIChatApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(delegate.dependencies.authManager)
                .environment(delegate.dependencies.userManager)
                .environment(delegate.dependencies.aiManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencies: AppDependencies!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        dependencies = AppDependencies()
        
        return true
    }
}

@MainActor
struct AppDependencies {
    let authManager: AuthManager
    let userManager: UserManager
    let aiManager: AIManager
    
    init() {
        self.authManager = AuthManager(service: FirebaseAuthService())
        self.userManager = UserManager(services: ProductionUserServices())
        self.aiManager = AIManager(service: OpenAIService())
    }
}
