//
//  PostComment.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 1/27/21.
//

import Foundation

struct PostComment {
    let text: String
    let user: User
    let date: Date
    
    static func mockComments() -> [PostComment] {
        let user = User(username: "Hamid",
                        profilePictureURL: nil,
                        identifier: UUID().uuidString)
        var comments = [PostComment]()
        
        let text = ["this is coll!",
                    "this is great!",
                    "I am learning so much!"]

        for comment in text {
            comments.append(PostComment(text: comment, user: user, date: Date()))
        }
        return comments
    }
}
