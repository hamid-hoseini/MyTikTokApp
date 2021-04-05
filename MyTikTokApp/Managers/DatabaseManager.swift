//
//  DatabaseManager.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 1/16/21.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    public static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    private init() {}
    
    
    public func inserUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        // get current user
        // insert new entry
        // create root users
        database.child("users").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard var userDictionary = snapshot.value as? [String: Any] else {
                self?.database.child("users").setValue([
                    username: [
                        "email": email
                    ]
                ]) { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    completion(true)
                }
                return
            }
            
            userDictionary[username] = ["email": email]
            
            // save new user object
            self?.database.child("users").setValue(userDictionary, withCompletionBlock: { error, _ in
                guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            })
        }
    }
    
    public func getAllUsers(completion: ([String]) -> Void) {
        
    }
}
