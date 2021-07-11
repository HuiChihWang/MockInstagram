//
//  SearchController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit

class SearchController: UITableViewController {

    private var allUsers = [User]()
    private var filteredUsers = [User]()
    
    private var displayUsers: [User] {
        isInSeachMode ? filteredUsers : allUsers
    }
    
    private var isNoResultDisplayed: Bool {
        return displayUsers.isEmpty
    }
    
    private var isInSeachMode: Bool {
        searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    private let searchController: UISearchController = {
       let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SearchResultTableCell.self, forCellReuseIdentifier: "\(SearchResultTableCell.self)")
        tableView.register(NothingFoundCell.self, forCellReuseIdentifier: "\(NothingFoundCell.self)")
        
        // TODO: Get dig into search controller
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        
        fetchAllUsers()
    }
    
    private func fetchAllUsers() {
        UserService.fetchAllUsers { users in
            self.allUsers = users
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        isNoResultDisplayed ? 1 : displayUsers.count
        allUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell: UITableViewCell!
//        
//        if isNoResultDisplayed {
//            cell = tableView.dequeueReusableCell(withIdentifier: "\(NothingFoundCell.self)", for: indexPath)
//        } else {
//            cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchResultTableCell.self)", for: indexPath)
//            (cell as? SearchResultTableCell)?.user = displayUsers[indexPath.row]
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchResultTableCell.self)", for: indexPath)
        (cell as? SearchResultTableCell)?.user = displayUsers[indexPath.row]
        
        return cell
    }
}

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        print("[DEBUG] Search Updater: updating \(query)")

        filteredUsers = allUsers.filter({ user in
            return user.userName.contains(query) || user.fullName.contains(query)
        })

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
