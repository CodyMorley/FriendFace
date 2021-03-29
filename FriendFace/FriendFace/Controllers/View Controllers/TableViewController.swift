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
        searchSetup()
        fetchFriends()
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = filteredFriends[indexPath.row]
        
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.friendList
        return cell
    }
    
    
    // MARK: - Search Results Updater
    func updateSearchResults(for searchController: UISearchController) {
        filteredFriends = friends.matching(searchController.searchBar.text)
        tableView.reloadData()
    }
    
    
    // MARK: - Private Methods
    private func fetchFriends() {
        let url = "https://www.hackingwithswift.com/samples/friendface.json"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        decoder.decode([Friend].self, fromURL: url, completion: { friends in
            self.friends = friends
            self.filteredFriends = friends
            self.tableView.reloadData()
        })
    }
    
    private func searchSetup() {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find A Friend"
        search.searchResultsUpdater = self
        navigationItem.searchController = search
    }
}
