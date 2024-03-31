//
//  UserCommentTableViewCell.swift
//  STYLiSH
//
//  Created by Kyle Lu on 2024/3/30.
//  Copyright © 2024 AppWorks School. All rights reserved.
//

import UIKit

class UserCommentTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let commentLabel = UILabel()
    var starsViews = [UIImageView]()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        // 設定 nameLabel 的屬性
        nameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        nameLabel.textColor = .darkGray
        
        // 設定 commentLabel 的屬性
        commentLabel.font = .systemFont(ofSize: 18)
        commentLabel.textColor = .darkGray
        commentLabel.numberOfLines = 0
        
        // 添加元件到 contentView
        contentView.addSubview(nameLabel)
        contentView.addSubview(commentLabel)
        
        // 呼叫下面的配置方法
        setupConstraints()
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            commentLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        setupStars()
    }
    
    private func setupStars() {
        // 清除舊的星星視圖
        starsViews.forEach { $0.removeFromSuperview() }
        starsViews.removeAll()

        // 創建並新增新的星星視圖
        for _ in 0..<Constants.starsCount {
            let star = makeStarIcon()
            starsViews.append(star)
            contentView.addSubview(star)
            star.translatesAutoresizingMaskIntoConstraints = false
        }

        // 設置星星的約束條件
        for (index, starView) in starsViews.enumerated() {
            let leftAnchor = index == 0 ? nameLabel.leadingAnchor : starsViews[index - 1].trailingAnchor
            NSLayoutConstraint.activate([
                starView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
                starView.leadingAnchor.constraint(equalTo: leftAnchor, constant: index == 0 ? 0 : 5),
                starView.heightAnchor.constraint(equalToConstant: 20),
                starView.widthAnchor.constraint(equalTo: starView.heightAnchor)
            ])
        }
        
        if let lastStar = starsViews.last {
            lastStar.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16).isActive = true
        }
    }
    
    private func makeStarIcon() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "icon_unfilled_star"), highlightedImage: UIImage(named: "icon_filled_star"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func updateStars(rating: Int) {
        setupStars()
        for (index, starView) in starsViews.enumerated() {
            starView.isHighlighted = index < rating
        }
    }
    
    // MARK: - Constants
    
    private struct Constants {
        static let starsCount: Int = 5
        static let sendButtonHeight: CGFloat = 50
        static let containerHorizontalInsets: CGFloat = 30
        static let starContainerHeight: CGFloat = 40
    }
}

