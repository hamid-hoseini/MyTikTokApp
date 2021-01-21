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
    
    public func getAllUsers(completion: ([String]) -> Void) {
        
    }
}
