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
}
