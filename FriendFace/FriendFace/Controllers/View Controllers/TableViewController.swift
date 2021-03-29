//
//  TableViewController.swift
//  FriendFace
//
//  Created by Cody Morley on 3/29/21.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
    // MARK: - Properties -
    var friends = [Friend]()
    var filteredFriends = [Friend]()

    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find A Friend"
        search.searchResultsUpdater = self
        navigationItem.searchController = search
        
        DispatchQueue.global().async {
            do {
                let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let downloadedFriends = try decoder.decode([Friend].self, from: data)
                
                DispatchQueue.main.async {
                    self.friends = downloadedFriends
                    self.filteredFriends = downloadedFriends
                    self.tableView.reloadData()
                }
            } catch {
                NSLog("\(error.localizedDescription)")
            }
        }
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = filteredFriends[indexPath.row]
        
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.friends.map { $0.name }.joined(separator: ",")
        return cell
    }
    
    
    // MARK: - Search Results Updater
    func updateSearchResults(for searchController: UISearchController) {
        filteredFriends = friends.matching(searchController.searchBar.text)
        tableView.reloadData()
    }
}
