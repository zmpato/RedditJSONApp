//
//  FeedController.swift
//  RedditJSONApp
//
//  Created by Zak Mills on 9/4/21.
//

import UIKit



class FeedContoller: UIViewController {
    
    let reuseIdentifier = "FeedCell"
    var result: RedditData?
    var contentArray = [ContentArray]()
    var collectionView: UICollectionView?
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        jsonDataCall {
            self.collectionView?.reloadData()
            print("THEARRAY: \(self.contentArray)")
        }
        configureUI()
    }
    
    
    
    func configureUI() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
    }
}

