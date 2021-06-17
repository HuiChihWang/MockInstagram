//
//  MainTabBarController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureControllers()
        // Do any additional setup after loading the view.
        
    }
    
    private func configureControllers() {
        let feed = templateNavigationController(iconName: "home", rootViewController: FeedController())
        
        let search = templateNavigationController(iconName: "search", rootViewController: SearchController())
        
        let imageSelector = templateNavigationController(iconName: "plus", rootViewController: ImageSelectorController())
        
        let notifications = templateNavigationController(iconName: "like", rootViewController: NotificationController())
        
        let profile = templateNavigationController(iconName: "profile", rootViewController: ProfileController())
        
        viewControllers = [feed, search, imageSelector, notifications, profile]
        tabBar.tintColor = .black
    }
    
    private func templateNavigationController(iconName: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.image = UIImage(named: "\(iconName)_unselected")
        nav.tabBarItem.selectedImage = UIImage(named: "\(iconName)_selected")
        nav.navigationBar.tintColor = .black
        
        return nav
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
