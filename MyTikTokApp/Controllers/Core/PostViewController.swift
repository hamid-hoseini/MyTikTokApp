//
//  PostViewController.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 1/16/21.
//

import UIKit

class PostViewController: UIViewController {

    let model: PostModel
    
    init(model: PostModel) {
        self.model = model
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors: [UIColor] = [.red, .blue, .white, .gray, .orange, .systemPink]
        
        view.backgroundColor = colors.randomElement()
    }


}
