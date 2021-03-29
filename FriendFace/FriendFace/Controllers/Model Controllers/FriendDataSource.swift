//
//  FriendDataSource.swift
//  FriendFace
//
//  Created by Cody Morley on 3/29/21.
//

import UIKit

class FriendDataSource: NSObject, UITableViewDataSource {
    // MARK: - Properties
    var friends = [Friend]()
    var filteredFriends = [Friend]()
    var dataChanged: (() -> Void)?
    var filterText: String? {
        didSet {
            filteredFriends = friends.matching(filterText)
            dataChanged?()
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = filteredFriends[indexPath.row]
        
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.friendList
        return cell
    }
    
    
    // MARK: - Methods
    func fetchFriends() {
        let url = "https://www.hackingwithswift.com/samples/friendface.json"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        decoder.decode([Friend].self, fromURL: url, completion: { friends in
            self.friends = friends
            self.filteredFriends = friends
            self.dataChanged?()
        })
    }
}
