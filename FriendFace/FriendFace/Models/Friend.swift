//
//  Friend.swift
//  FriendFace
//
//  Created by Cody Morley on 3/29/21.
//

import Foundation

struct Friend: Codable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Connection]
    
    var friendList: String {
        return friends.map { $0.name }.joined(separator: ", ")
    }
}
