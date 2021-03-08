//
//  ExploreManager.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 3/5/21.
//

import Foundation
import UIKit

protocol ExploreManagerDelegate: AnyObject {
    func pushViewController(_ vc: UIViewController)
    func didTapHashtag(_ hashtag: String)
}

final class ExploreManager {
    static let shared = ExploreManager()
    
    weak var delegate: ExploreManagerDelegate?
    
    enum BannerActtion: String {
        case post
        case hashtag
        case user
    }
    
    // MARK: - Public functions
    
    public func getExploreBanners() -> [ExploreBannerViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        
        return exploreData.banners.compactMap({ model in
            ExploreBannerViewModel(
                image: UIImage(named: model.image),
                title: model.title)
                { [weak self] in
                    guard let action = BannerActtion(rawValue: model.action) else {
                        return
                    }
                DispatchQueue.main.async {
                    let vc = UIViewController()
                    vc.view.backgroundColor = .systemBackground
                    vc.title = action.rawValue.uppercased()
                    self?.delegate?.pushViewController(vc)
                }

                    switch action {
                    case .user:
                        // profile
                        break
                    case .post:
                        // post
                        break
                    case .hashtag:
                        // search for hashtag
                        break
                    }
                }
        })
    }
    
    public func getExploreCreators() -> [ExploreUserViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        
        return exploreData.creators.compactMap({ model in
            ExploreUserViewModel(
                profilePicture: UIImage(named: model.image),
                username: model.username,
                followerCount: model.followers_count)
            { [weak self] in
                DispatchQueue.main.async {
                    let userId = model.id
                    // Fetch user objct from firebase
                    let vc = ProfileViewController(user: User(username: "Hamid", profilePictureURL: nil, identifier: userId))
                    self?.delegate?.pushViewController(vc)
                }
            }
        })
    }
    
    public func getExploreHashtags() -> [ExploreHashtagViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        
        return exploreData.hashtags.compactMap({ model in
            ExploreHashtagViewModel(
                icon: UIImage(named: model.image),
                text: "#" + model.tag,
                count: model.count)
            { [weak self] in
                DispatchQueue.main.async {
                    self?.delegate?.didTapHashtag(model.tag)
                }
            }
        })
    }
    
    public func getExploreTrendingPosts() -> [ExplorePostViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        
        return exploreData.trendingPosts.compactMap({ model in
            ExplorePostViewModel(
                thumbnailImage: UIImage(named: model.image),
                caption: model.caption)
            { [weak self] in
                DispatchQueue.main.async {
                    // usert id to fetch posts from firebase
                    let postId = model.id
                    let vc = PostViewController(model: PostModel(identifier: postId))
                    self?.delegate?.pushViewController(vc)
                }
            }
        })
    }
    
    public func getExploreRecentPosts() -> [ExplorePostViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        
        return exploreData.recentPosts.compactMap({ model in
            ExplorePostViewModel(
                thumbnailImage: UIImage(named: model.image),
                caption: model.caption)
            { [weak self] in
                DispatchQueue.main.async {
                    // usert id to fetch posts from firebase
                    let postId = model.id
                    let vc = PostViewController(model: PostModel(identifier: postId))
                    self?.delegate?.pushViewController(vc)
                }
            }
        })
    }
    
    public func getExplorePopularPosts() -> [ExplorePostViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        
        return exploreData.popular.compactMap({ model in
            ExplorePostViewModel(
                thumbnailImage: UIImage(named: model.image),
                caption: model.caption)
            { [weak self] in
                DispatchQueue.main.async {
                    // usert id to fetch posts from firebase
                    let postId = model.id
                    let vc = PostViewController(model: PostModel(identifier: postId))
                    self?.delegate?.pushViewController(vc)
                }
            }
        })
    }
    
    // MARK: - Private functions
    
    private func parseExploreData() -> ExploreResponse? {
        guard let path = Bundle.main.path(forResource: "explore", ofType: "json") else {
            return nil
        }
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(ExploreResponse.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}

struct ExploreResponse: Codable {
    let banners: [Banner]
    let trendingPosts: [Post]
    let creators: [Creator]
    let recentPosts: [Post]
    let hashtags: [Hashtag]
    let popular: [Post]
    let recommended: [Post]
}

struct Banner: Codable {
   let id: String
   let image: String
   let title: String
   let action: String
}

struct Post: Codable {
   let id: String
   let image: String
   let caption: String
}

struct Hashtag: Codable {
   let image: String
   let tag: String
    let count: Int
}

struct Creator: Codable {
    let id: String
    let image: String
    let username: String
    let followers_count: Int
}
