//
//  ContentViewModel.swift
//  RedditJSONApp
//
//  Created by Zak Mills on 9/4/21.
//

import UIKit

struct ContentArray {
    let titles: String?
    let subreddits: String?
    let thumbnails: String?
    let thumbnail_heights: Int?
    let thumbnail_widths: Int?
    let scores: Int?
    let num_comments: Int?
}

extension FeedContoller {
    func attachJSON() {
        networkManager.jsonDataCall(completed: { [weak self] result in
            switch result {
            case .success:
                self?.networkManager.contentArray.append(contentsOf: (self?.networkManager.contentArray)!)
                DispatchQueue.main.async {
                    self?.collectionView?.reloadData()
                }
            case .failure(_):
                break
            }
        })
        
    }
}

