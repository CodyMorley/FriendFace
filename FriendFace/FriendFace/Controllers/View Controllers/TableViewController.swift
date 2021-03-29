//
//  TableViewController.swift
//  FriendFace
//
//  Created by Cody Morley on 3/29/21.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
    // MARK: - Properties -
    let dataSource = FriendDataSource()
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        searchSetup()
    }
    
    
    // MARK: - Search Results Updater
    func updateSearchResults(for searchController: UISearchController) {
        dataSource.filterText = searchController.searchBar.text
    }
    
    
    // MARK: - Private Methods
    private func searchSetup() {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find A Friend"
        search.searchResultsUpdater = self
        navigationItem.searchController = search
    }
    
    private func setupDataSource() {
        dataSource.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        dataSource.fetchFriends()
        tableView.dataSource = dataSource
    }
}
