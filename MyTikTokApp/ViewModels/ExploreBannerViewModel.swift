//
//  ExploreBannerViewModel.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 2/8/21.
//

import Foundation
import UIKit

struct ExploreBannerViewModel {
    let imageView: UIImage?
    let title: String
    let handler: (() -> Void)
}
