//
//  User.swift
//  iOSBaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 1/1/24.
//

import Foundation

//https://jsonplaceholder.typicode.com/users
//https://jsonplaceholder.typicode.com/posts

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
