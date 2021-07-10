//
//  SearchController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit

class SearchController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SearchResultTableCell.self, forCellReuseIdentifier: "\(SearchResultTableCell.self)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}


extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchResultTableCell.self)", for: indexPath)
        
        return cell
    }
}
