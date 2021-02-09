//
//  ExplorePostViewModel.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 2/8/21.
//

import Foundation
import UIKit

struct ExplorePostViewModel {
    let thumbnailImage: UIImage?
    let caption: String
    let handler: (() -> Void)
}
