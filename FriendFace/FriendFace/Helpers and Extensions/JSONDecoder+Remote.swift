//
//  JSONDecoder+Remote.swift
//  FriendFace
//
//  Created by Cody Morley on 3/29/21.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, fromURL url: String, completion: @escaping (T) -> Void) {
        guard let url = URL(string: url) else {
            fatalError("Passed bad URL")
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                
                let downloadedData = try self.decode(type, from: data)
                
                DispatchQueue.main.async {
                    completion(downloadedData)
                }
            } catch {
                NSLog("\(error.localizedDescription)")
            }
        }
    }
}
