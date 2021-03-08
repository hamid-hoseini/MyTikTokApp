//
//  ExploreUserViewModel.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 2/8/21.
//

import Foundation
import UIKit

struct ExploreUserViewModel {
    let profilePicture: UIImage?
    let username: String
    let followerCount: Int
    let handler: (() -> Void)
}
