//
//  ExploreBannerCollectionViewCell.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 3/4/21.
//

import UIKit

class ExploreBannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "ExploreBannerCollectionViewCell"
 
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        imageView.frame = contentView.bounds
        label.frame = CGRect(x: 10,
                             y: contentView.height - 5 - label.height,
                             width: label.width,
                             height: label.height)
        contentView.bringSubviewToFront(label)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        label.text = nil
    }
    
    func configure(with viewModel: ExploreBannerViewModel) {
        imageView.image = viewModel.image
        label.text = viewModel.title
    }
    
}
