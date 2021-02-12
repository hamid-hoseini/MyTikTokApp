//
//  ExploreViewController.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 1/16/21.
//

import UIKit

class ExploreViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.layer.cornerRadius = 8
        searchBar.layer.masksToBounds = true
        return searchBar
    }()
    
    private var sections = [ExploreSection]()
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureModel()
        setupSearchBar()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }

    func setupSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    func configureModel() {
        var cells = [ExploreCell]()
        for _ in 0...1000 {
            let cell = ExploreCell.banner(viewModel: ExploreBannerViewModel(
                                            imageView: nil,
                                            title: "Foo",
                                            handler: {}))
            cells.append(cell)
        }
        
        //Banner
        sections.append(
            ExploreSection(
                type: .banners,
                cells: cells
        ))
        
        // trending posts
        
        var posts = [ExploreCell]()
        for _ in 1...40 {
            posts.append(ExploreCell.post(
                            viewModel: ExplorePostViewModel(
                                thumbnailImage: nil,
                                caption: "",
                                handler: {
                                    
                                })))
        }
        
        sections.append(
            ExploreSection(
                type: .trendingPosts,
                cells: posts
            ))
        
        // users
        sections.append(
            ExploreSection(
                type: .users,
                cells: [
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                        
                    })),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                        
                    })),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                        
                    })),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                        
                    })),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                        
                    })),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "", followerCount: 0, handler: {
                        
                    }))
                    
                ]
            ))
        
        // trending hashtags
        sections.append(
            ExploreSection(
                type: .trendingHashtags,
                cells: [
                    .hashtag(viewModel: ExploreHashtagViewModel(icon: nil, text: "#foryou", count: 1, handler: {
                        
                    })),
                    .hashtag(viewModel: ExploreHashtagViewModel(icon: nil, text: "#foryou", count: 1, handler: {
                        
                    })),
                    .hashtag(viewModel: ExploreHashtagViewModel(icon: nil, text: "#foryou", count: 1, handler: {
                        
                    })),
                    .hashtag(viewModel: ExploreHashtagViewModel(icon: nil, text: "#foryou", count: 1, handler: {
                        
                    })),
                    .hashtag(viewModel: ExploreHashtagViewModel(icon: nil, text: "#foryou", count: 1, handler: {
                        
                    })),
                    .hashtag(viewModel: ExploreHashtagViewModel(icon: nil, text: "#foryou", count: 1, handler: {
                        
                    }))
                    
                ]
            ))
        
        // recommended
        sections.append(
            ExploreSection(
                type: .recommended,
                cells: [
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    }))
                ]
            ))
        
        // popular
        sections.append(
            ExploreSection(
                type: .popular,
                cells: [
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    }))
                ]
            ))
        
        // new / recent items
        sections.append(
            ExploreSection(
                type: .new,
                cells: [
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    })),
                    .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {
                        
                    }))
                ]
            ))
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    func layout(for section: Int) -> NSCollectionLayoutSection {
        let sectionType = sections[section].type
        
        switch sectionType {
            case .banners:
                // Create Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1))
                    )
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
                
                // Create group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.9),
                        heightDimension: .absolute(200))
                    ,
                    subitems: [item])
            
                // Section Layout
                let sectionLayout = NSCollectionLayoutSection(group: group)
                sectionLayout.orthogonalScrollingBehavior = .groupPaging
                // Return
                return sectionLayout
                
            case .users:
                // Create Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1))
                    )
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
                
                // Create group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(200),
                        heightDimension: .absolute(200))
                    ,
                    subitems: [item])
            
                // Section Layout
                let sectionLayout = NSCollectionLayoutSection(group: group)
                sectionLayout.orthogonalScrollingBehavior = .groupPaging
                // Return
                return sectionLayout
                
            case .trendingHashtags:
                // Create Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1))
                    )
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
                
                // Create group
                let verticalGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(60))
                    ,
                    subitems: [item])
            
                // Section Layout
                let sectionLayout = NSCollectionLayoutSection(group: verticalGroup)
                //sectionLayout.orthogonalScrollingBehavior = .groupPaging
                // Return
                return sectionLayout
                
        case .trendingPosts, .recommended, .new:
            // Create Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
                )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            // Create group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(240))
                ,
                subitem: item,
                count: 2)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(110),
                    heightDimension: .absolute(240)),
                subitems: [verticalGroup])
        
            // Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            // Return
            return sectionLayout
            
        case .popular:
            // Create Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
                )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            // Create group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(110),
                    heightDimension: .absolute(200)),
                subitems: [item])
        
            // Section Layout
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            // Return
            return sectionLayout
        }
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = sections[indexPath.section].cells[indexPath.row] //sections[indexPath.section].cells[indexPath.row]
        
        switch model {
            
        case .banner(let viewModel):
            break
        case .post(let viewModel):
            break
        case .hashtag(let viewModel):
            break
        case .user(let viewModel):
            break
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    
}

extension ExploreViewController: UISearchBarDelegate {
    
}
