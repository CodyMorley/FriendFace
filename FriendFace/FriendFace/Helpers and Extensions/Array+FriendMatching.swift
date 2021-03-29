//
//  Array+FriendMatching.swift
//  FriendFace
//
//  Created by Cody Morley on 3/29/21.
//

import Foundation

extension Array where Element == Friend {
    func matching(_ text: String?) -> [Friend] {
        if let text = text, text.count > 0 {
            return self.filter {
                $0.name.contains(text)
                || $0.company.contains(text)
                || $0.address.contains(text)
            }
        } else {
            return self
        }
    }
}
