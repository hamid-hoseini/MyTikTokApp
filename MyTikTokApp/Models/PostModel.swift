//
//  PostModel.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 1/23/21.
//

import Foundation

struct PostModel {
    let identifier: String
    var isLikedByCurrentUser = false;
    let user = User(username: "hamid", profilePictureURL: nil, identifier: UUID().uuidString)
    
    
    static func mockModels() -> [PostModel] {
        var posts = [PostModel]()
        
        for _ in 0...100 {
            let post = PostModel(identifier: UUID().uuidString)
            posts.append(post)
        }
        return posts
    }
}
