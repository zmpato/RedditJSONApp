//
//  FeedTableView.swift
//  RedditJSONApp
//
//  Created by Zak Mills on 9/4/21.
//

import UIKit



extension FeedContoller: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.networkManager.contentArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        let content = networkManager.contentArray[indexPath.row]
        cell.configure(cell, forReturning: content)
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > ((collectionView?.contentSize.height)!-scrollView.frame.size.height)-100 && self.networkManager.result?.data.children.count ?? 0 > 1{
            guard !networkManager.isPaginating else {
                return
            }
            
            networkManager.newData = true
            networkManager.jsonDataCall(pagination: true) { [weak self] result in
                switch result {
                case .success(true):
                    self?.networkManager.contentArray.append(contentsOf: (self?.networkManager.contentArray)!)
                    DispatchQueue.main.async {
                        self?.collectionView?.reloadData()
                    }
                case .failure(_):
                    break
                case .success(false):
                    self?.networkManager.contentArray.append(contentsOf: (self?.networkManager.contentArray)!)
                    DispatchQueue.main.async {
                        self?.collectionView?.reloadData()
                    }
                }
            }
        }
    }
    
    
}

extension FeedContoller: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
   
}

