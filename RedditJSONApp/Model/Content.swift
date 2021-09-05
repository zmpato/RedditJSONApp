//
//  Content.swift
//  RedditJSONApp
//
//  Created by Zak Mills on 9/4/21.
//

import UIKit

struct RedditData: Codable {
   
    let data: ParentDictionary
}

struct ParentDictionary: Codable {
    let children: [Children]
    let after: String?

}

struct Children: Codable {
    let data: Data
    
    
}



struct Data: Codable {
    let title: String?
    let subreddit: String?
    let thumbnail: String?
    let thumbnail_height: Int?
    let thumbnail_width: Int?
    let score: Int?
    let num_comments: Int?
   
}









