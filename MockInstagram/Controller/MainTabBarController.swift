//
//  MainTabBarController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    private var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggedIn()
    }
    
    private func checkIfUserLoggedIn() {
        if AuthService.currentUser == nil {
            print("[DEBUG] No user: enter log in controller")
            DispatchQueue.main.async {
                let logInController = LoginController.createLogInController(delegate: self)
                self.present(logInController, animated: true, completion: nil)
            }
        } else {
            fetchUser()
        }
    }
    
    private func fetchUser() {
        UserService.fetchCurrentUser { user in
            self.currentUser = user
            self.configureControllers()
        }
    }
    
    private func configureControllers() {
        guard let user = currentUser else {
            return
        }
        
        let feedController = FeedController()
        feedController.authDelegate = self
        feedController.user = currentUser
        let feed = templateNavigationController(iconName: "home", rootViewController: feedController)
        
        let search = templateNavigationController(iconName: "search", rootViewController: SearchController())
        
        let imageSelector = templateNavigationController(iconName: "plus", rootViewController: ImageSelectorController())
        
        let notifications = templateNavigationController(iconName: "like", rootViewController: NotificationController())
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationController(iconName: "profile", rootViewController: profileController)
        
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

extension MainTabBarController: AuthenticationDelegate {
    func didAuthenticationComplete() {
        print("[DEBUG] AuthenticationDelegate from MainTabBar: didAuthenticationComplete")
        self.fetchUser()
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func didLogout() {
        print("[DEBUG] Logout user: \(AuthService.currentUser?.displayName ?? "")")
        AuthService.logOut()
        checkIfUserLoggedIn()
    }
}
