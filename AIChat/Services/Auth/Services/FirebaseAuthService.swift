//
//  FirebaseAuthService.swift
//  AIChat
//
//  Created by Artem Panasenko on 28.01.2025.
//

import FirebaseAuth
import SignInAppleAsync

struct FirebaseAuthService: AuthService {
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        
        return UserAuthInfo(user: user)
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let result = try await Auth.auth().signInAnonymously()
        return result.asAuthInfo
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let helper = await SignInWithAppleHelper()
        let response = try await helper.signIn()
        
        let credential = OAuthProvider.credential(
            providerID: AuthProviderID.apple,
            idToken: response.token,
            rawNonce: response.nonce
        )
        
        if let user = Auth.auth().currentUser, user.isAnonymous {
            do {
                // Try to link to existing anonymous account
                let result = try await user.link(with: credential)
                return result.asAuthInfo
            } catch let error as NSError {
                let authErrorCode = AuthErrorCode(rawValue: error.code)
                
                switch authErrorCode {
                case .accountExistsWithDifferentCredential, .credentialAlreadyInUse:
                    if let secondaryCredential = error.userInfo["FIRAuthErrorUserInfoUpdatedCredentialKey"] as? AuthCredential {
                        let result = try await Auth.auth().signIn(with: secondaryCredential)
                        return result.asAuthInfo
                    }
                default:
                    break
                }
                
            }
        }
        
        // Otherwise sign in to new account
        let result = try await Auth.auth().signIn(with: credential)
        return result.asAuthInfo
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        try await user.delete()
    }
    
    enum AuthError: LocalizedError {
        case userNotFound
        
        var errorDescription: String? {
            switch self {
            case .userNotFound:
                return "Current authenticated user not found."
            }
        }
    }
}
