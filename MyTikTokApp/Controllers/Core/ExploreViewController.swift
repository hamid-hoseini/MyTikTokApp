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
                                            image: UIImage(named: "test"),
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
                                thumbnailImage: UIImage(named: "test"),
                                caption: "This is a really cool post and long caption!",
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
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "Hamid", followerCount: 0, handler: {
                        
                    })),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "Mary", followerCount: 0, handler: {
                        
                    })),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "Danyal", followerCount: 0, handler: {
                        
                    })),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "Rebeka", followerCount: 0, handler: {
                        
                    })),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "Parham", followerCount: 0, handler: {
                        
                    })),
                    .user(viewModel: ExploreUserViewModel(profilePictureURL: nil, username: "Rojan", followerCount: 0, handler: {
                        
                    }))
                    
                ]
            ))
        
        // trending hashtags
        sections.append(
            ExploreSection(
                type: .trendingHashtags,
                cells: [
                    .hashtag(viewModel: ExploreHashtagViewModel(icon: UIImage(systemName: "bell"), text: "#foryou", count: 1, handler: {
                        
                    })),
                    .hashtag(viewModel: ExploreHashtagViewModel(icon: UIImage(systemName: "bell"), text: "#iPhone12", count: 1, handler: {
                        
                    })),
                    .hashtag(viewModel: ExploreHashtagViewModel(icon: UIImage(systemName: "house"), text: "#Luxuary House", count: 1, handler: {
                        
                    })),
                    .hashtag(viewModel: ExploreHashtagViewModel(icon: UIImage(systemName: "car"), text: "#BMW x6", count: 1, handler: {
                        
                    })),
                    .hashtag(viewModel: ExploreHashtagViewModel(icon: UIImage(systemName: "airplane"), text: "#Pilot", count: 1, handler: {
                        
                    })),
                    .hashtag(viewModel: ExploreHashtagViewModel(icon: UIImage(systemName: "camera"), text: "#Turist", count: 1, handler: {
                        
                    }))
                    
                ]
            ))
        
        // recommended
        sections.append(
            ExploreSection(
                type: .recommended,
                cells: posts
            ))
        
        // popular
        sections.append(
            ExploreSection(
                type: .popular,
                cells: posts
            ))
        
        // new / recent items
        sections.append(
            ExploreSection(
                type: .new,
                cells: posts
            ))
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "cell")
        
        collectionView.register(
            ExploreBannerCollectionViewCell.self,
            forCellWithReuseIdentifier: ExploreBannerCollectionViewCell.identifier)
        
        collectionView.register(
            ExplorePostCollectionViewCell.self,
            forCellWithReuseIdentifier: ExplorePostCollectionViewCell.identifier)
        
        collectionView.register(
            ExploreUserCollectionViewCell.self,
            forCellWithReuseIdentifier: ExploreUserCollectionViewCell.identifier)
        
        collectionView.register(
            ExploreHashtagCollectionViewCell.self,
            forCellWithReuseIdentifier: ExploreHashtagCollectionViewCell.identifier)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
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
            guard let cell = collectionView.dequeueReusableCell(
                      withReuseIdentifier: ExploreBannerCollectionViewCell.identifier,
                      for: indexPath) as? ExploreBannerCollectionViewCell else {
                  return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
              }
            cell.configure(with: viewModel)
            return cell
        case .post(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                      withReuseIdentifier: ExplorePostCollectionViewCell.identifier,
                      for: indexPath) as? ExplorePostCollectionViewCell else {
                  return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
              }
            cell.configure(with: viewModel)
            return cell
            
        case .hashtag(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                      withReuseIdentifier: ExploreHashtagCollectionViewCell.identifier,
                      for: indexPath) as? ExploreHashtagCollectionViewCell else {
                  return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
              }
            cell.configure(with: viewModel)
            return cell
            
        case .user(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                      withReuseIdentifier: ExploreUserCollectionViewCell.identifier,
                      for: indexPath) as? ExploreUserCollectionViewCell else {
                  return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
              }
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        HapticsManager.shared.viberateForSelection()
        
        let model = sections[indexPath.section].cells[indexPath.row]
        switch model {
        case .banner(let viewModel):
            //viewModel.handler()
            break
        case .post(let viewModel):
            //viewModel.handler()
            break
        case .hashtag(let viewModel):
            //viewModel.handler()
            break
        case .user(let viewModel):
            //viewModel.handler()
            break
        }
    }
}

extension ExploreViewController: UISearchBarDelegate {
    
}

// MARK: Section Layout

extension ExploreViewController {
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
                        widthDimension: .absolute(150),
                        heightDimension: .absolute(200))
                    ,
                    subitems: [item])
            
                // Section Layout
                let sectionLayout = NSCollectionLayoutSection(group: group)
                sectionLayout.orthogonalScrollingBehavior = .continuous
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
                    heightDimension: .absolute(300))
                ,
                subitem: item,
                count: 2)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(110),
                    heightDimension: .absolute(300)),
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
