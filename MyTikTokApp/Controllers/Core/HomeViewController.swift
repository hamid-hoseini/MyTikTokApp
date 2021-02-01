//
//  ViewController.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 1/16/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        //scrollView.backgroundColor = .red
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let control: UISegmentedControl = {
        let titles = ["Following",  "For You"]
        let control = UISegmentedControl(items: titles)
        control.backgroundColor = nil
        control.selectedSegmentTintColor = .white
        control.selectedSegmentIndex = 1
        return control
    }()
    
    let forYouPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:])
    
    let followingPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:])
    
    private var forYouPosts = PostModel.mockModels()
    private var followingPosts = PostModel.mockModels()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .red
        view.addSubview(horizontalScrollView)
        setupFeed()
        horizontalScrollView.delegate = self
        horizontalScrollView.contentOffset = CGPoint(x: view.width, y: 0)
        setupHeaderButtons()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        horizontalScrollView.frame = view.bounds
    }
    
    func setupHeaderButtons() {
        control.addTarget(self, action: #selector(didChangeSegmentControl(_:)), for: .valueChanged)
        navigationItem.titleView = control
    }
    
    @objc private func didChangeSegmentControl(_ sender: UISegmentedControl) {
        horizontalScrollView.setContentOffset(CGPoint(x: view.width * CGFloat(sender.selectedSegmentIndex),
                                                      y: 0),
                                              animated: true)
    }
    
    private func setupFeed() {
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        
        setupFollowingFeed()
        setupForYouFeed()
    }
    
    func setupFollowingFeed() {
//        let vc = UIViewController()
//        vc.view.backgroundColor = .blue
        
        guard let model = followingPosts.first else {
            return
        }
        let vc = PostViewController(model: model)
        vc.delegate = self
        forYouPageViewController.setViewControllers([vc],
                                                       direction: .forward,
                                                       animated: false,
                                                       completion: nil)
        
        forYouPageViewController.dataSource = self
        
        horizontalScrollView.addSubview(forYouPageViewController.view)
        forYouPageViewController.view.frame = CGRect(x: 0,
                                             y: 0,
                                             width: horizontalScrollView.width,
                                             height: horizontalScrollView.height)
        addChild(followingPageViewController)
        forYouPageViewController.didMove(toParent: self)
    }
    
    func  setupForYouFeed() {
//        let vc = UIViewController()
//        vc.view.backgroundColor = .blue
  
        guard let model = forYouPosts.first else {
            return
        }
        
        let vc = PostViewController(model: model)
        vc.delegate = self
        followingPageViewController.setViewControllers([vc],
                                                    direction: .forward,
                                                    animated: false,
                                                    completion: nil)
        
        followingPageViewController.dataSource = self
        
        horizontalScrollView.addSubview(followingPageViewController.view)
        followingPageViewController.view.frame =  CGRect( x: view.width,
                                               y: 0,
                                               width: horizontalScrollView.width,
                                               height: horizontalScrollView.height)
        addChild(followingPageViewController)
        followingPageViewController.didMove(toParent: self)
    }
}

extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        
        guard let index = currentPosts.firstIndex(where: {
            $0.identifier == fromPost.identifier
            
        }) else {
            return nil
        }
        
        if index == 0 {
            return nil
        }
        
        let priorIndex = index - 1
        let model = currentPosts[priorIndex]
        
        let vc = PostViewController(model: model)
        vc.delegate = self
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        let vc = UIViewController()
//        vc.view.backgroundColor = [UIColor.green, UIColor.black, UIColor.gray, UIColor.brown].randomElement()
//        return vc
        
        guard let fromPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        
        guard let index = currentPosts.firstIndex(where: {
            $0.identifier == fromPost.identifier
            
        }) else {
            return nil
        }
        
        guard index < (currentPosts.count - 1) else {
            return nil
        }
        
        let nextIndex = index+1
        let model = currentPosts[nextIndex]
        
        let vc = PostViewController(model: model)
        vc.delegate = self
        return vc
        
          
    }
    
    var currentPosts: [PostModel] {
        if horizontalScrollView.contentOffset.x == 0 {
            // Following Page
            
            return followingPosts
        }
        
        // For You Page
        return forYouPosts
        
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 || scrollView.contentOffset.x <= (view.width / 2){
            control.selectedSegmentIndex = 0
        }
        else if scrollView.contentOffset.x > (view.width / 2) {
            control.selectedSegmentIndex = 1
        }
    }
    
}

extension HomeViewController: PostViewControllerDelegate {
    func postViewController(_ vc: PostViewController, didTapCommentButtonFor post: PostModel) {
        horizontalScrollView.isScrollEnabled = false;
        
        if horizontalScrollView.contentOffset.x == 0 {
            // following  
            followingPageViewController.dataSource = nil
        }
        else {
            forYouPageViewController.dataSource = nil
        }
        let vc = CommentsViewController(post: post)
        vc.delegate = self
        addChild(vc)
        vc.didMove(toParent: self)
        view.addSubview(vc.view)
        let frame: CGRect = CGRect(x: 0, y: view.height, width: view.width, height: view.height * 0.75)
        vc.view.frame = frame
        UIView.animate(withDuration: 0.2) {
            vc.view.frame = CGRect(x: 0, y: self.view.height - frame.height, width: frame.width, height: frame.height)
        }
    }
    
    func postViewController(_ vc: PostViewController, didTapProfileButtonFor post: PostModel) {
        let user = post.user
        let vc = ProfileViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: CommentViewControllerDelegate {
    func didTapCloseForComments(with viewController: CommentsViewController) {
        // close comments with animation
        let frame = viewController.view.frame
        UIView.animate(withDuration: 0.2) {
            viewController.view.frame = CGRect(x: 0, y: self.view.height, width: frame.width, height: frame.height)
            
        } completion: { [weak self] done in
            if done {
                DispatchQueue.main.async {
                    // remove comment vc as child
                    viewController.view.removeFromSuperview()
                    viewController.removeFromParent()
                    
                    // Allow horizontal and vertical scroll
                    self?.horizontalScrollView.isScrollEnabled = true
                    self?.followingPageViewController.dataSource = self
                    self?.forYouPageViewController.dataSource = self
                }
            }
        }
        
    }
}
