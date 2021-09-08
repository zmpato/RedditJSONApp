//
//  NetworkManager.swift
//  RedditJSONApp
//
//  Created by Zak Mills on 9/8/21.
//

import UIKit

class NetworkManager {
    
    var result: RedditData?
    var contentArray = [ContentArray]()
    var isPaginating = false
    var newData = false
    var urlString: String?
    
    
    func jsonDataCall(pagination: Bool = false, completed: @escaping (Result<Bool, Error>) -> Void) {
        if pagination {
            isPaginating = true
        }
        
        if newData == false {
            urlString = "https://www.reddit.com/.json"
        } else {
            urlString = "http://www.reddit.com/.json?after=\(self.result?.data.after ?? "")"
        }
        
        guard let url = URL(string: urlString ?? "https://www.reddit.com/.json") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return }
            
            self.result = try? JSONDecoder().decode(RedditData.self, from: data)
            
            DispatchQueue.main.async {
                
                for index in 0..<(self.result?.data.children.count ?? 0) {
                    
                    let titles = self.result?.data.children[index].data.title
                    let subreddits = self.result?.data.children[index].data.subreddit
                    let thumbnails = self.result?.data.children[index].data.thumbnail
                    let thumbnail_heights = self.result?.data.children[index].data.thumbnail_height
                    let thumbnail_widths = self.result?.data.children[index].data.thumbnail_width
                    let scores = self.result?.data.children[index].data.score
                    let comments = self.result?.data.children[index].data.num_comments
                    let contentArray = ContentArray(titles: titles ?? "", subreddits: subreddits ?? "", thumbnails: thumbnails ?? "", thumbnail_heights: thumbnail_heights ?? 0, thumbnail_widths: thumbnail_widths ?? 0, scores: scores ?? 0, num_comments: comments ?? 0)
                    self.contentArray.append(contentArray)
                }
                completed(.success(pagination ? self.isPaginating == true : self.isPaginating == false))
                if pagination {
                    self.isPaginating = false
                }
            }
            
            print("THEURL \(self.urlString)")
            
        }.resume()
    }
}
