//
//  MainTabBarController.swift
//  MockInstagram
//
//  Created by Hui Chih Wang on 2021/6/17.
//

import UIKit
import Firebase
import YPImagePicker

class MainTabBarController: UITabBarController {
    private var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
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
        
        // test usage
        let imageSelector = templateNavigationController(iconName: "plus", rootViewController: UploadPostViewController())
        
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
    
    private func createImageSelector() -> UIViewController {
        // TODO: Dig into configuration setting on github
        var imagePickerConfig = YPImagePickerConfiguration()
        imagePickerConfig.library.mediaType = .photo
        imagePickerConfig.shouldSaveNewPicturesToAlbum = false
        imagePickerConfig.startOnScreen = .library
        imagePickerConfig.screens = [.library]
        imagePickerConfig.hidesStatusBar = false
        imagePickerConfig.hidesBottomBar = false
        imagePickerConfig.library.maxNumberOfItems = 1
        
        let imageSelector = YPImagePicker(configuration: imagePickerConfig)
        imageSelector.didFinishPicking { item, _ in
            DispatchQueue.main.async {
                print("[DEBUG] YPImagePicker: select photo \(item.singlePhoto?.image)")
                imageSelector.dismiss(animated: true)
            }
        }
        
        return imageSelector
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

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let controllerIndex = viewControllers?.firstIndex(of: viewController) else {
            return false
        }
        
//        if controllerIndex == 2 {
//            print("[DEBUG] MainTabBar Controller: select image controller")
//            let imagePicker = createImageSelector()
//            imagePicker.modalPresentationStyle = .fullScreen
//            present(imagePicker, animated: true)
//            return false
//        }
        
        return true
    }
    
    
}
