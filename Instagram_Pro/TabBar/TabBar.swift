//
//  TabBar.swift
//  Instagram_Pro
//
//  Created by DAWEIXU on 2018/10/16.
//  Copyright © 2018 unimelb_daweixu. All rights reserved.
//

import UIKit
import Firebase

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        let UserFeedNavController = templateNavController(Image: #imageLiteral(resourceName: "userfeed"), rootViewController: UserFeed())
        
        //Discover
        let DiscoverNavController = templateNavController(Image: #imageLiteral(resourceName: "discover"),rootViewController: Discover())
        
        //Photo
        let PhotoNavController = templateNavController(Image: #imageLiteral(resourceName: "photo"),rootViewController: Photo())
        
        //ActivityFeed
        let ActivityFeedNavController = templateNavController(Image: #imageLiteral(resourceName: "activityfeed"),rootViewController: ActivityFeed())
        
        //Profile
        let layout = UICollectionViewFlowLayout()
        let ProfileController = Profile(collectionViewLayout: layout)
        let ProfileNavController = UINavigationController(rootViewController: ProfileController)
        ProfileController.tabBarItem.image = #imageLiteral(resourceName: "profile")
    
        tabBar.tintColor = .black
        
        viewControllers = [UserFeedNavController,
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
