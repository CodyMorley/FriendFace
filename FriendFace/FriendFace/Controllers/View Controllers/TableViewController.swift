//
//  TableViewController.swift
//  FriendFace
//
//  Created by Cody Morley on 3/29/21.
//

import UIKit

class TableViewController: UITableViewController {
    // MARK: - Properties -
    let dataSource = FriendDataSource()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        dataSource.fetchFriends()
        tableView.dataSource = dataSource
        
        searchSetup()
    }
    
    // MARK: - Private Methods
    private func searchSetup() {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find A Friend"
        search.searchResultsUpdater = dataSource
        navigationItem.searchController = search
    }
}
