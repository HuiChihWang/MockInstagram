//
//  UserListController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/7/20.
//

import Foundation
import UIKit

class UsersTableViewController: UITableViewController {
    var userIds = [String]()
    private var users = [User]()
    
    override func viewDidLoad() {
        tableView.register(UserTableCell.self, forCellReuseIdentifier: "\(UserTableCell.self)")
        fetchFollowers()
    }
    
    
    private func fetchFollowers() {
        UserService.fetchUsers(with: userIds) { users in
            self.users = users
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension UsersTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserTableCell.self)", for: indexPath)
        
        (cell as? UserTableCell)?.user = users[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("[DEBUG] user table view controller : select on user \(users[indexPath.row].userName)")
        let profileController = ProfileController(userID: users[indexPath.row].uid)
        navigationController?.pushViewController(profileController, animated: true)
    }
}
