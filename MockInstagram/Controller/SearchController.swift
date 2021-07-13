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
    
    private var isFetching = true
    
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
        tableView.register(FetchingCell.self, forCellReuseIdentifier: "\(FetchingCell.self)")
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchAllUsers()
    }
    
    private func fetchAllUsers() {
        isFetching = true
        UserService.fetchAllUsers { users in
            self.allUsers = users
            self.isFetching = false
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFetching || isNoResultDisplayed {
            return 1
        }
        
        return displayUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!

        if isFetching {
            cell = tableView.dequeueReusableCell(withIdentifier: "\(FetchingCell.self)", for: indexPath)
        }
        else if isNoResultDisplayed {
            cell = tableView.dequeueReusableCell(withIdentifier: "\(NothingFoundCell.self)", for: indexPath)
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchResultTableCell.self)", for: indexPath)
            (cell as? SearchResultTableCell)?.user = displayUsers[indexPath.row]
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("[DEBUG] search controller : select on user \(displayUsers[indexPath.row].userName)")
        let profileController = ProfileController(user: displayUsers[indexPath.row])
        navigationController?.pushViewController(profileController, animated: true)
    }
}

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text?.lowercased() ?? ""
//        print("[DEBUG] Search Updater: updating \(query)")

        filteredUsers = allUsers.filter({ user in
            return user.userName.contains(query) || user.fullName.contains(query)
        })

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
