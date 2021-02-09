//
//  ExploreHashtagViewModel.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 2/8/21.
//

import Foundation
import UIKit

struct ExploreHashtagViewModel {
    let icon: UIImage?
    let text: String
    let count: Int // Number of posts associated with tag
    let handler: (() -> Void)
}
