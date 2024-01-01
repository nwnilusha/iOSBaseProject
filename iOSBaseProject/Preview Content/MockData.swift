//
//  MockData.swift
//  iOSBaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 1/1/24.
//

import Foundation

extension User {
    static var mockUsers: [User] {
        Bundle.main.decode([User].self, from: "Users.json")
    }
    
    static var mockSingleUsers: User {
        self.mockUsers[0]
    }
}

extension Post {
    static var mockPosts: [Post] {
        Bundle.main.decode([Post].self, from: "Posts.json")
    }
    
    static var mockSinglePost: Post {
        self.mockPosts[0]
    }
    
    static var mockSingleUserPostArray: [Post] {
        self.mockPosts.filter{ $0.userId == 1}
    }
}
