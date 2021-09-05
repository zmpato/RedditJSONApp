//
//  FeedCell.swift
//  RedditJSONApp
//
//  Created by Zak Mills on 9/4/21.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    static let reuseIdentifier = "FeedCell"
    
     var postImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .gray
        
        return iv
    }()
    
     let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Geeza Pro Regular", size: 20)
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 10
        label.text = "Test Text"
        
        return label
    }()
    
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "message.fill"), for: .normal)
        button.tintColor = .systemGray4
        button.setDimensions(width: 35, height: 35)
        
        return button
    }()
    
    let commentCountLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 14)
       label.numberOfLines = 1
       label.text = "122"
        
       return label
   }()
    
    private lazy var scoreButtonUp: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        button.tintColor = .systemGray4
        button.setDimensions(width: 35, height: 35)
       
        return button
    }()
    
    private lazy var scoreButtonDown: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.down.circle.fill"), for: .normal)
        button.tintColor = .systemGray4
        button.setDimensions(width: 35, height: 35)
       
        return button
    }()
    
    let scoreCountLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 14)
       label.numberOfLines = 1
       label.text = "12345"
        
       return label
   }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        
        contentView.addSubview(captionLabel)
        captionLabel.centerX(inView: contentView)
        captionLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 15, paddingRight: 15)
        captionLabel.sizeToFit()
        captionLabel.textAlignment = .center
        
        contentView.addSubview(postImage)
        postImage.centerX(inView: contentView)
        postImage.centerY(inView: contentView)
        postImage.anchor(top: captionLabel.bottomAnchor, paddingTop: 10)
            
        
        let buttonStackLeft = UIStackView(arrangedSubviews: [scoreButtonUp, scoreCountLabel, scoreButtonDown])
        buttonStackLeft.axis = .horizontal
        scoreCountLabel.textAlignment = .center
        buttonStackLeft.setDimensions(width: 120, height: 73)
        buttonStackLeft.spacing = 2
        
        
        
        contentView.addSubview(commentCountLabel)
        commentCountLabel.anchor(bottom: bottomAnchor, right: rightAnchor, paddingBottom: 40, paddingRight: 50)
        contentView.addSubview(commentButton)
        commentButton.anchor(bottom: bottomAnchor, right: commentCountLabel.leftAnchor, paddingBottom: 32, paddingRight: 2)
        
        addSubview(buttonStackLeft)
        buttonStackLeft.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 30, paddingBottom: 10)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
}
