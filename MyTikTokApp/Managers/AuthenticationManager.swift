//
//  AuthenticationManager.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 1/16/21.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    public static let shared = AuthManager()
        
    private init() {}
    
    enum SignInMethod {
        case email
        case facebook
        case google
    }
    
    public func signIn(with method: SignInMethod) {
    }
    
    public func signOut() {
        
    }
}
