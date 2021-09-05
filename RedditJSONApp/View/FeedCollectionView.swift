//
//  FeedTableView.swift
//  RedditJSONApp
//
//  Created by Zak Mills on 9/4/21.
//

import UIKit



extension FeedContoller: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.result?.data.children.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        cell.contentView.backgroundColor = .white
        cell.captionLabel.text = contentArray[indexPath.row].titles
        cell.captionLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        let height = contentArray[indexPath.row].thumbnail_heights
        let width = contentArray[indexPath.row].thumbnail_widths
        cell.postImage.frame.size = CGSize(width: width ?? 0, height: height ?? 0)
        
        let scoreCount = contentArray[indexPath.row].scores
        cell.scoreCountLabel.text = "\(scoreCount ?? 0)"
        cell.scoreCountLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        
        let commentCount = contentArray[indexPath.row].num_comments
        cell.commentCountLabel.text = "\(commentCount ?? 0)"
        cell.commentCountLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        
        
        if let url = URL(string: contentArray[indexPath.row].thumbnails ?? "") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { /// execute on main thread
                    cell.postImage.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
        
        
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > ((collectionView?.contentSize.height)!-scrollView.frame.size.height)-100 && self.result?.data.children.count ?? 0 > 1{
            print("FETCHING MORE DATA")
            if let url = URL(string: "http://www.reddit.com/.json?after=\(self.result?.data.after ?? "")") {
               
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

extension FeedContoller {
    func jsonDataCall(completed: @escaping () -> ()) {
        
        
        
       
        guard let url = URL(string: "https://www.reddit.com/.json") else {
            fatalError("Invalid URL")
        }
        
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return }
           
                
            self.result = try? JSONDecoder().decode(RedditData.self, from: data)


            DispatchQueue.main.async {
                completed()
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
            }
        
         
                
            print("http://www.reddit.com/.json?after=\(self.result?.data.after ?? "")")
            
            
            
        }.resume()
        
    }
}
