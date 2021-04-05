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
    
    enum AuthError: Error {
        case signInFailed
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    public func signIn(with email: String,
                       password: String,
                       completion: @escaping (Result<String, Error>) -> Void ) {
        
        Auth.auth().signIn(withEmail: email, password: password) {
            result, error in
            guard result != nil, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                else {
                    completion(.failure(AuthError.signInFailed))
                }
                return
            }
            
            // successful sign in
            completion(.success(email))
        }
    }

    public func signUp(with username: String,
                       email: String,
                       password: String,
                       completion: @escaping (Bool) -> Void ) {
        
        // Make sure created username is available
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            DatabaseManager.shared.inserUser(with: email, username: username, completion: completion)
        }
    }
    
    public func signOut(completion : (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            print(error)
            completion(false)
            
        }
    }
}
