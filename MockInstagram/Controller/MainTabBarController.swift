//
//  MainTabBarController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit
import Firebase


class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureControllers()
        checkIfUserLoggedIn()
        
    }
    
    func checkIfUserLoggedIn() {
        if AuthService.currentUser == nil {
            print("[DEBUG] No user: enter log in controller")
            DispatchQueue.main.async {
                let logInController = LoginController.createLogInController()
                self.present(logInController, animated: true, completion: nil)
            }
        }
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
}
