//
//  FeedController.swift
//  RedditJSONApp
//
//  Created by Zak Mills on 9/4/21.
//

import UIKit



class FeedContoller: UIViewController {
    
    let reuseIdentifier = "FeedCell"
    var collectionView: UICollectionView?
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachJSON()
        configureUI()
    }
    
    
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        view.addSubview(topBar)
        topBar.setDimensions(width: view.frame.width, height: 50)
        topBar.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
        
    }

    var topBar: UIView = {
        let tb = UIView()
        tb.backgroundColor = .systemGray6
        return tb
    }()
}

