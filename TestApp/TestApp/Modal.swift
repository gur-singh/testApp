//
//  Modal.swift
//  TestApp
//
//  Created by Gurpreet Singh on 01/11/18.
//  Copyright © 2018 Gurpreet. All rights reserved.
//

import Foundation
struct  Hits {
     var created_at : String?
     var title : String?
     var url : String?
     var author : String?
     var points : Int?
     var story_text : String?
     var comment_text : String?
     var num_comments : Int?
     var story_id : String?
     var story_title : String?
     var story_url : String?
     var parent_id : String?
     var created_at_i : Int?
     var objectID : String?
   
      init(dictionary: NSDictionary) {
        
        created_at = dictionary["created_at"] as? String
        title = dictionary["title"] as? String
        url = dictionary["url"] as? String
        author = dictionary["author"] as? String
        points = dictionary["points"] as? Int
        story_text = dictionary["story_text"] as? String
        comment_text = dictionary["comment_text"] as? String
        num_comments = dictionary["num_comments"] as? Int
        story_id = dictionary["story_id"] as? String
        story_title = dictionary["story_title"] as? String
        story_url = dictionary["story_url"] as? String
        parent_id = dictionary["parent_id"] as? String
        created_at_i = dictionary["created_at_i"] as? Int
        objectID = dictionary["objectID"] as? String
    }
    
    
    
}


