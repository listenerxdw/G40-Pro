//
//  TabBar.swift
//  Instagram_Pro
//
//  Created by DAWEIXU on 2018/10/16.
//  Copyright © 2018 unimelb_daweixu. All rights reserved.
//

import UIKit
import Firebase
import Photos

class TabBar: UITabBarController,UITabBarControllerDelegate {
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        //when click on camera
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                
                print("Showing camera")
                
                let cameraController = Camera()
                self.present(cameraController, animated: true, completion: nil)
            }))
            
            alertController.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
                let layout = UICollectionViewFlowLayout()
                let uploadPhoto = UploadPhotoController(collectionViewLayout: layout)
                let navController = UINavigationController(rootViewController: uploadPhoto)
                self.present(navController, animated: true, completion: nil)
            }))
            
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
                
                
            return false
        }
        
        return true
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            //show if not logged in
            DispatchQueue.main.async {
                self.present(UINavigationController(rootViewController: Login()), animated: true, completion: nil)
            }
            return
        }
        setupViewControllers()
        
    }
        
    func setupViewControllers() {
        //UserFeed
        
        let userFeedlayout = UICollectionViewFlowLayout()
        let userFeedController = UserFeed(collectionViewLayout: userFeedlayout)
        let userFeedNavController = UINavigationController(rootViewController: userFeedController)
        userFeedController.tabBarItem.image = #imageLiteral(resourceName: "userfeed")
        
        //Discover
        let DiscoverNavController = templateNavController(Image: #imageLiteral(resourceName: "discover"),rootViewController: Discover(collectionViewLayout: UICollectionViewFlowLayout()))
        
        
        //Photo
        let PhotoNavController = templateNavController(Image: #imageLiteral(resourceName: "photo"),rootViewController: UploadPhotoController())
        
        //ActivityFeed
        let ActivityFeedNavController = templateNavController(Image: #imageLiteral(resourceName: "activityfeed"),rootViewController: ActivityFeed(collectionViewLayout: (UICollectionViewFlowLayout())))
        
        //Profile
        let layout = UICollectionViewFlowLayout()
        let ProfileController = Profile(collectionViewLayout: layout)
        let ProfileNavController = UINavigationController(rootViewController: ProfileController)
        ProfileController.tabBarItem.image = #imageLiteral(resourceName: "profile")
    
        tabBar.tintColor = .black
        
        viewControllers = [userFeedNavController,
                           DiscoverNavController,
                           PhotoNavController,
                           ActivityFeedNavController,
                           ProfileNavController]
        
        //modify tab bar item insets
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func templateNavController(Image: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = Image
        return navController
    }

}
